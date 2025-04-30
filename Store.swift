//
//  Store.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 28/11/24.
//

import Foundation
import StoreKit

typealias Transaction = StoreKit.Transaction
typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

public enum StoreError: Error {
    case failedVerification
}

public enum SubscriptionTier: Int, Comparable {
    case none = 0
    case monthly = 1
    case yearly = 2
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

class Store: ObservableObject {
    @Published private(set) var lifetime: [Product]
    @Published private(set) var subscriptions: [Product]
    @Published private(set) var purchasedSubscriptions: [Product] = []
    @Published private(set) var purchasedLifetime: Bool = false
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    
    var updateListenerTask: Task<Void, Error>? = nil
    private let productIds: [String: String]
    static let shared = Store()
    
    private init() {
        productIds = Store.loadProductIdData()
        subscriptions = []
        lifetime = []
        updateListenerTask = listenForTransactions()
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    static func loadProductIdData() -> [String: String] {
        guard let path = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
              let plist = FileManager.default.contents(atPath: path),
              let data = try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String] else {
            return [:]
        }
        return data
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                } catch {
                    print("Transaction verification failed")
                }
            }
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedSubscriptions: [Product] = []
        purchasedLifetime = false
        subscriptionGroupStatus = nil
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try self.checkVerified(result)
                switch transaction.productType {
                case .nonConsumable:
                    purchasedLifetime = true
                case .autoRenewable:
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        if let expirationDate = transaction.expirationDate {
                            if expirationDate > Date() {
                                purchasedSubscriptions.append(subscription)
                            } else {
                                print("Subscription expired for \(subscription.displayName)")
                            }
                        }
                    }
                default:
                    break
                }
            } catch {
                print("Failed to verify transaction: \(error)")
            }
        }
        
        self.purchasedSubscriptions = purchasedSubscriptions
        self.subscriptionGroupStatus = try? await subscriptions.first?.subscription?.status.first?.state
    }
    
    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: productIds.values)
            
            var newLifetime: [Product] = []
            var newSubscriptions: [Product] = []
            
            for product in storeProducts {
                switch product.type {
                case .nonConsumable:
                    newLifetime.append(product)
                case .autoRenewable:
                    newSubscriptions.append(product)
                default:
                    print("unknown product")
                }
            }
            
            lifetime = sortByPrice(newLifetime)
            subscriptions = sortByPrice(newSubscriptions)
        } catch {
            print("Failed product request from the app store server with error: \(error)")
        }
    }
    
    func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted { $0.price < $1.price }
    }
    
    func isSubscriptionActive(productId: String) async -> Bool {
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try self.checkVerified(result)
                if transaction.productID == productId, let expirationDate = transaction.expirationDate {
                    return expirationDate > Date()
                }
            } catch {
                print("Failed to verify subscription status for \(productId)")
            }
        }
        return false
    }
    
    func tier(for productId: String) -> SubscriptionTier {
        switch productId {
        case "monthly_subscription":
            return .monthly
        case "yearly_subscription":
            return .yearly
        default:
            return .none
        }
    }
    
    func purchased(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            await updateCustomerProductStatus()
            await transaction.finish()
            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
}
