////
////  FirebaseDataViewModel.swift
////  MinimalDesk
////
////  Created by Rakib Hasan on 12/7/24.
////
//
//import Foundation
//import Combine
//import Firebase
//import WidgetKit
//import SwiftUI
//import Network
//
//public class FirebaseDataViewModel: ObservableObject {
//    private let favAppsKey = "favorite-apps"
//    private let customAppsKey = "custom-apps"
//    
//    private var remoteAppList: [Appp] = []
//    private let dbRef = Firestore.firestore().collection("AppList")
//    private let userdefault = UserDefaults(suiteName: "group.minimaldesk")
//    
//    @Published var cards: Int = UserDefaults.standard.value(forKey: UserDefaultsKeys.numberOfFavAppList.rawValue) as? Int ?? 1
//    @Published var appList = [Appp]()
//    @Published var customAppList: [Appp] = []
//    @Published var onlyAppName = [String]()
//    @Published var favApps: [[[String: String]]]
//    @Published var appsOnAddView: [[String]]
//    
//    static private var viewModel: FirebaseDataViewModel?
//    static var shared: FirebaseDataViewModel {
//        if viewModel == nil {
//            viewModel = FirebaseDataViewModel()
//        }
//        
//        return viewModel!
//    }
//    
//    private init() {
//        favApps = []
//        appsOnAddView = []
//        (0...20).forEach { _ in
//            appsOnAddView.append([])
//            favApps.append([])
//        }
//        getFavAppsFromCache()
//    }
//}
//
//// MARK: - Public APIs
//extension FirebaseDataViewModel {
//    func prepareAppList() {
//        getAllCustomApps()
//        if remoteAppList.isEmpty {
//            fetchAllAppsFromServer()
//        } else {
//            mergeRemoteAndLocalApps()
//        }
//    }
//    
//    func saveFavoriteApps(in selectedIndices: Set<String>, for cardIndex: Int) {
//        var favApps = appList.map { app in
//            guard selectedIndices.contains(app.appName) else { return [String: String]() }
//            
//            return ["name": app.appName, "link": app.appLink, "rank": "\(app.appRank)"]
//        }
//            .filter { $0 != [String: String]() }
//        
//        guard let userdefault else {
//            log("Did not find userdefault.")
//            return
//        }
//        
//        if selectedIndices.count <= self.favApps[cardIndex].count {
//            var noChange = true
//            for appName in selectedIndices {
//                noChange = self.favApps[cardIndex].contains { favApp in
//                    favApp["name"] == appName
//                }
//                
//                if noChange == false { break }
//            }
//            
//            if noChange {
//                favApps = self.favApps[cardIndex].filter { favApp in
//                    selectedIndices.contains(where: { selected in
//                        selected == favApp["name"]
//                    })
//                }
//            }
//        }
//        
//        
//        self.favApps[cardIndex] = favApps
//        
//        setAppsOnAddView(for: cardIndex)
//        
//        userdefault.set(favApps, forKey: favAppsKey + "\(cardIndex)")
//        WidgetCenter.shared.reloadTimelines(ofKind: "FavAppWidget\(cardIndex)")
//    }
//    
//    func addCustomApp(_ app: Appp) {
//        customAppList.append(app)
//        
//        guard let userdefault else {
//            log("Did not find userdefault.")
//            return
//        }
//        
//        let customAppDictList = customAppList.map { ["name": $0.appName, "link": $0.appLink, "rank": "\($0.appRank)"] }
//        log("Custom Apps: \(customAppDictList)")
//        
//        userdefault.set(customAppDictList, forKey: customAppsKey) // TODO: add cardIndex
//        prepareAppList()
//    }
//}
//
//// MARK: - Helper Methods
//private extension FirebaseDataViewModel {
//    func getAllCustomApps() {
//        customAppList = (userdefault?.value(forKey: customAppsKey) as? [[String: String]] ?? [])
//            .map { Appp(appName: $0["name"] ?? "", appLink: $0["link"] ?? "", appRank: Int(($0["rank"] ?? "")) ?? 0) }
//            .filter { !$0.appName.isEmpty && !$0.appLink.isEmpty && $0.appRank != 0 }
//        
//        log("Custom Apps: \(customAppList)")
//    }
//    
//    func fetchAllAppsFromServer() {
//        var remoteAppList = [Appp]()
//        var onlyAppName = [String]()
//        
//        dbRef.getDocuments { [weak self] snapshot, error in
//            guard error == nil else {
//                log("Failed with - \(String(describing: error))")
//                return
//            }
//            
//            snapshot?.documents.forEach { document in
//                let doc = document.data()
//                guard
//                    let appName = doc["appName"] as? String,
//                    let appLink = doc["appLink"] as? String
//                else {
//                    log("Did not find the properties name and/or link")
//                    return
//                }
//                
//                let rankStr = doc["rank"] as? String ?? ""
//                let rank = Int(rankStr) ?? doc["rank"] as? Int
//                
//                guard let rank else {
//                    log("Couldn't find rank.")
//                    return
//                }
//                
//                log(doc)
//                
//                remoteAppList.append(Appp(appName: appName, appLink: appLink, appRank: rank))
//                if !onlyAppName.contains(appName) {
//                    onlyAppName.append(appName)
//                }
//            }
//            
//            guard let self else {
//                print("[FirebaseDataViewModel] [fetchAllSubscribers] self is nil")
//                return
//            }
//            
//            log("Successfully fetched app list.")
//            
//            self.remoteAppList = remoteAppList
//            mergeRemoteAndLocalApps()
//            
//            (0...20).forEach { cardIndex in
//                self.setAppsOnAddView(for: cardIndex)
//            }
//        }
//    }
//    
//    func mergeRemoteAndLocalApps() {
//        self.appList = self.customAppList + self.remoteAppList
//        self.appList = self.appList.sorted { $0.appRank < $1.appRank }
//        self.onlyAppName = self.appList.map { $0.appName }
//    }
//    
//    func getFavAppsFromCache() {
//        (0...20).forEach { cardIndex in
//            favApps[cardIndex] = userdefault?.value(forKey: favAppsKey + "\(cardIndex)") as? [[String: String]] ?? []
//            setAppsOnAddView(for: cardIndex)
//        }
//    }
//    
//    func setAppsOnAddView(for cardIndex: Int = 0) {
//        if !favApps[cardIndex].isEmpty {
//            appsOnAddView[cardIndex] = favApps[cardIndex].map { $0["name"] ?? "Nil" }
//        } else {
//            appsOnAddView[cardIndex] = appList.prefix(6).map { $0.appName }
//        }
//        
//        log(appsOnAddView)
//    }
//}
//
//extension FirebaseDataViewModel {
//    func setInitialFavApps(initalFavApps: [[String: String]]) {
//        favApps[0] = initalFavApps
//        setAppsOnAddView()
//        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.initallySelectedFavApps.rawValue)
//        userdefault?.set(initalFavApps, forKey: favAppsKey + "0")
//    }
//    
//    func setFavAppsOnReorder(index: Int) {
//        let convertedDictionary = appsOnAddView[index].map { appName in
//            guard let appIndex = appList.firstIndex(where: { app in
//                app.appName == appName
//            }) else {
//                return [String: String]()
//            }
//            
//            let app = appList[appIndex]
//            return ["name": app.appName, "link": app.appLink, "rank": "\(app.appRank)"]
//        }
//        
//        userdefault?.set(convertedDictionary, forKey: favAppsKey + "\(index)")
//        favApps[index] = convertedDictionary
//        setAppsOnAddView(for: index)
//    }
//    
//    func setFavOnDeleteCard(cardIndex: Int) {
//        if cardIndex == cards - 1 {
//            favApps[cardIndex] = []
//        } else {
//            for position in (cardIndex..<(cards - 1)) {
//                favApps[position] = favApps[position + 1]
//                userdefault?.set(favApps[position], forKey: favAppsKey + "\(position)")
//            }
//        }
//        
//        cards -= 1
//        UserDefaults.standard.set(cards, forKey: UserDefaultsKeys.numberOfFavAppList.rawValue)
//        
//        for ind in cards...20 {
//            favApps[ind] = []
//            userdefault?.set(nil, forKey: favAppsKey + "\(ind)")
//        }
//        getFavAppsFromCache()
//    }
//}
//
//// MARK: - Models
//struct Appp: Codable, Equatable {
//    let appName: String
//    let appLink: String
//    let appRank: Int
//}
//
//// MARK: - Extensions
//extension String {
//    var isNotEmpty: Bool { !isEmpty }
//}
//
//
//
//





import Foundation
import Combine
import Firebase
import WidgetKit
import SwiftUI
import Network

public class FirebaseDataViewModel: ObservableObject {
    private let favAppsKey = "favorite-apps"
    private let customAppsKey = "custom-apps"
    private let appListKey = "saved-app-list" // Key for saving appList in UserDefaults
    
    private var remoteAppList: [Appp] = []
    private let dbRef = Firestore.firestore().collection("AppList")
    private let userdefault = UserDefaults(suiteName: "group.minimaldesk")
    
    @Published var cards: Int = UserDefaults.standard.value(forKey: UserDefaultsKeys.numberOfFavAppList.rawValue) as? Int ?? 1
    @Published var appList = [Appp]()
    @Published var customAppList: [Appp] = []
    @Published var onlyAppName = [String]()
    @Published var favApps: [[[String: String]]]
    @Published var appsOnAddView: [[String]]
    
    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""
    
    static private var viewModel: FirebaseDataViewModel?
    static var shared: FirebaseDataViewModel {
        if viewModel == nil {
            viewModel = FirebaseDataViewModel()
        }
        return viewModel!
    }
    
    private init() {
        favApps = []
        appsOnAddView = []
        (0...20).forEach { _ in
            appsOnAddView.append([])
            favApps.append([])
        }
        getFavAppsFromCache()
        loadSavedAppList() // Load appList from UserDefaults
    }
}

// MARK: - Public APIs
extension FirebaseDataViewModel {
    func prepareAppList() {
        getAllCustomApps()
        if isConnectedToInternet() {
            fetchAllAppsFromServer()
        } else {
            showToast(message: "No internet connection. Loading saved data.")
            loadSavedAppList() // Fallback to saved data if no internet
        }
    }
    
    func saveFavoriteApps(in selectedIndices: Set<String>, for cardIndex: Int) {
        var favApps = appList.map { app in
            guard selectedIndices.contains(app.appName) else { return [String: String]() }
            print(app.appName)
            return ["name": app.appName, "link": app.appLink, "rank": "\(app.appRank)"]
        }.filter { $0 != [String: String]() }
        
        guard let userdefault else {
            log("Did not find userdefault.")
            return
        }
        
        self.favApps[cardIndex] = favApps
        setAppsOnAddView(for: cardIndex)
        userdefault.set(favApps, forKey: favAppsKey + "\(cardIndex)")
        WidgetCenter.shared.reloadTimelines(ofKind: "FavAppWidget\(cardIndex)")
    }
    
    func addCustomApp(_ app: Appp) {
        customAppList.append(app)
        guard let userdefault else {
            log("Did not find userdefault.")
            return
        }
        
        let customAppDictList = customAppList.map { ["name": $0.appName, "link": $0.appLink, "rank": "\($0.appRank)"] }
        log("Custom Apps: \(customAppDictList)")
        
        userdefault.set(customAppDictList, forKey: customAppsKey)
        prepareAppList()
    }
}

// MARK: - Helper Methods
private extension FirebaseDataViewModel {
    func getAllCustomApps() {
        customAppList = (userdefault?.value(forKey: customAppsKey) as? [[String: String]] ?? [])
            .map { Appp(appName: $0["name"] ?? "", appLink: $0["link"] ?? "", appRank: Int(($0["rank"] ?? "")) ?? 0) }
            .filter { !$0.appName.isEmpty && !$0.appLink.isEmpty && $0.appRank != 0 }
        
        log("Custom Apps: \(customAppList)")
    }
    
//    func fetchAllAppsFromServer() {
//        var remoteAppList = [Appp]()
//        
//        dbRef.getDocuments { [weak self] snapshot, error in
//            guard error == nil else {
//                log("Failed with - \(String(describing: error))")
//                DispatchQueue.main.async {
//                    self?.showToast(message: "Failed to fetch data. Loading saved data.")
//                    self?.loadSavedAppList() // Fallback to saved data if server fetch fails
//                }
//                return
//            }
//            
//            snapshot?.documents.forEach { document in
//                let doc = document.data()
//                guard
//                    let appName = doc["appName"] as? String,
//                    let appLink = doc["appLink"] as? String,
//                    let rank = doc["rank"] as? Int
//                else {
//                    log("Did not find the properties name and/or link")
//                    return
//                }
//                
//                remoteAppList.append(Appp(appName: appName, appLink: appLink, appRank: rank))
//            }
//            
//            guard let self else { return }
//            
//            self.remoteAppList = remoteAppList
//            self.mergeRemoteAndLocalApps()
//            self.saveAppListToUserDefaults() // Save the merged appList to UserDefaults
//            
//            (0...20).forEach { cardIndex in
//                self.setAppsOnAddView(for: cardIndex)
//            }
//        }
//    }
    
    func fetchAllAppsFromServer() {
        var remoteAppList = [Appp]()
        
        dbRef.getDocuments { [weak self] snapshot, error in
            guard error == nil else {
                log("Failed with - \(String(describing: error))")
                DispatchQueue.main.async {
                    self?.showToast(message: "Failed to fetch data. Loading saved data.")
                    self?.loadSavedAppList() // Fallback to saved data if server fetch fails
                }
                return
            }
            
            snapshot?.documents.forEach { document in
                let doc = document.data()
                
                // Ensure both appName and appLink are present
                guard
                    let appName = doc["appName"] as? String, !appName.isEmpty,
                    let appLink = doc["appLink"] as? String, !appLink.isEmpty
                else {
                    log("Missing appName or appLink")
                    return // Skip this document if appName or appLink is missing
                }
                
                // Optional: Check if appRank is available, otherwise, you can set a default value
                let rank = doc["rank"] as? Int ?? 0
                
                // Create the Appp object and add it to the remoteAppList
                remoteAppList.append(Appp(appName: appName, appLink: appLink, appRank: rank))
            }
            
            guard let self else { return }
            
            self.remoteAppList = remoteAppList
            self.mergeRemoteAndLocalApps()
            self.saveAppListToUserDefaults() // Save the merged appList to UserDefaults
            
            (0...20).forEach { cardIndex in
                self.setAppsOnAddView(for: cardIndex)
            }
        }
    }

    
    
    func mergeRemoteAndLocalApps() {
//        self.appList = (self.customAppList + self.remoteAppList)
//            .sorted { $0.appRank < $1.appRank }
        
        self.appList = (self.customAppList + self.remoteAppList)
            .sorted {
                if $0.appRank > 0 && $1.appRank > 0 {
                    return $0.appRank < $1.appRank
                } else if $0.appRank > 0 {
                    return true
                } else if $1.appRank > 0 {
                    return false
                } else {
                    return $0.appName.lowercased() < $1.appName.lowercased()
                }
            }

        self.onlyAppName = self.appList.map { $0.appName }
        
        print("All App Names: \(self.onlyAppName)")
    }
    
    func saveAppListToUserDefaults() {
        guard let userdefault else {
            log("Did not find userdefault.")
            return
        }
        let appListDictArray = appList.map { ["name": $0.appName, "link": $0.appLink, "rank": "\($0.appRank)"] }
        userdefault.set(appListDictArray, forKey: appListKey)
        log("Saved appList to UserDefaults.")
    }
    
    func loadSavedAppList() {
        guard let userdefault else {
            log("Did not find userdefault.")
            return
        }
        
        if let savedAppList = userdefault.value(forKey: appListKey) as? [[String: String]] {
            self.appList = savedAppList.compactMap { dict in
                guard
                    let appName = dict["name"],
                    let appLink = dict["link"],
                    let appRankStr = dict["rank"],
                    let appRank = Int(appRankStr)
                else {
                    return nil
                }
                return Appp(appName: appName, appLink: appLink, appRank: appRank)
            }
            
            self.onlyAppName = self.appList.map { $0.appName }
            log("Loaded appList from UserDefaults.")
        } else {
            log("No saved appList found in UserDefaults.")
        }
    }
    
    func getFavAppsFromCache() {
        (0...20).forEach { cardIndex in
            favApps[cardIndex] = userdefault?.value(forKey: favAppsKey + "\(cardIndex)") as? [[String: String]] ?? []
            setAppsOnAddView(for: cardIndex)
        }
    }
    
    func setAppsOnAddView(for cardIndex: Int = 0) {
        if !favApps[cardIndex].isEmpty {
            appsOnAddView[cardIndex] = favApps[cardIndex].map { $0["name"] ?? "Nil" }
        } else {
            appsOnAddView[cardIndex] = appList.prefix(6).map { $0.appName }
        }
        log(appsOnAddView)
    }
    
    func isConnectedToInternet() -> Bool {
        let monitor = NWPathMonitor()
        let semaphore = DispatchSemaphore(value: 0)
        var isConnected = false
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
            semaphore.signal()
        }
        
        monitor.start(queue: queue)
        semaphore.wait()
        monitor.cancel()
        
        return isConnected
    }
    
    func showToast(message: String) {
        DispatchQueue.main.async {
            self.toastMessage = message
            self.showToast = true
        }
    }
}

// MARK: - Public APIs
extension FirebaseDataViewModel {
    func setInitialFavApps(initalFavApps: [[String: String]]) {
        favApps[0] = initalFavApps
        setAppsOnAddView()
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.initallySelectedFavApps.rawValue)
        userdefault?.set(initalFavApps, forKey: favAppsKey + "0")
    }
    
    func setFavAppsOnReorder(index: Int) {
        let convertedDictionary = appsOnAddView[index].map { appName in
            guard let appIndex = appList.firstIndex(where: { app in
                app.appName == appName
            }) else {
                return [String: String]()
            }
            
            let app = appList[appIndex]
            return ["name": app.appName, "link": app.appLink, "rank": "\(app.appRank)"]
        }
        
        userdefault?.set(convertedDictionary, forKey: favAppsKey + "\(index)")
        favApps[index] = convertedDictionary
        setAppsOnAddView(for: index)
    }
    
    func setFavOnDeleteCard(cardIndex: Int) {
        if cardIndex == cards - 1 {
            favApps[cardIndex] = []
        } else {
            for position in (cardIndex..<(cards - 1)) {
                favApps[position] = favApps[position + 1]
                userdefault?.set(favApps[position], forKey: favAppsKey + "\(position)")
            }
        }
        
        cards -= 1
        UserDefaults.standard.set(cards, forKey: UserDefaultsKeys.numberOfFavAppList.rawValue)
        
        for ind in cards...20 {
            favApps[ind] = []
            userdefault?.set(nil, forKey: favAppsKey + "\(ind)")
        }
        getFavAppsFromCache()
    }
}

// MARK: - Models
struct Appp: Codable, Equatable {
    let appName: String
    let appLink: String
    let appRank: Int
}

// MARK: - Extensions
extension String {
    var isNotEmpty: Bool { !isEmpty }
}
