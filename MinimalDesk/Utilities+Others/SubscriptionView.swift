import SwiftUI
import StoreKit

struct SubscriptionView: View {
    @AppStorage("subscribed") private var subscribed: Bool = false
    @Environment(\.dismiss) var dismiss
    @State private var selectedPlan = PlanType.yearly.rawValue
    @State private var shouldShowProgressView = false
    @ObservedObject private var store: Store = Store.shared
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    ZStack(alignment: .top) {
                        Image(.subscriptionBG)
                            .resizable()
                            .scaledToFit()
                        
                        VStack {
                            HStack {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .onTapGesture {
                                        dismiss()
                                    }
                                
                                Spacer()
                                
                                Button("Restore") {
                                    Task {
                                        isLoading = true
                                        do {
                                            try await AppStore.sync()
                                            await store.updateCustomerProductStatus()
                                            await updateSubscriptionStatus()
                                        } catch {
                                            errorMessage = "Restore failed. Please try again."
                                        }
                                        isLoading = false
                                    }
                                }
                            }
                            .padding(.top, 30)
                            
                            Text("LessPhone Pro")
                                .font(.largeTitle)
                                .bold()
                            
                            Text("Break free from digital overlord.")
                        }
                        .padding()
                    }
                    
                    Text("Get Premium")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("All Widget Access", systemImage: "checkmark.circle.fill")
                        Label("Multiple Widget Setup", systemImage: "checkmark.circle.fill")
                        Label("Control Digital Distractions", systemImage: "checkmark.circle.fill")
                        //Label("Font Size", systemImage: "checkmark.circle.fill")
                        //Label("All Minimalist Wallpapers", systemImage: "checkmark.circle.fill")
                        //Label("All Minimal Icons", systemImage: "checkmark.circle.fill")
                        Label("Ability to add apps independently", systemImage: "checkmark.circle.fill")
                        Label("Lifetime Support", systemImage: "checkmark.circle.fill")
                        Label("Ad-free Experience", systemImage: "checkmark.circle.fill")
                    }
                    .font(.system(size: 16))
                    .padding([.leading, .bottom])
                    
                    VStack {
                        planButton(title: "$1.99 / Month", plan: .monthly)
                        planButton(title: "$4.99 / Year", subtitle: "With 3 Days Free Trial", plan: .yearly, imageName: "yearlySubscription")
                        planButton(title: "$9.99 / Lifetime", subtitle: "One-time Payment", plan: .lifetime)
                    }
                    .padding()
                    .frame(maxWidth: 300)
                    
                    Button {
                        Task {
                            await handlePurchase()
                        }
                    } label: {
                        Text("Continue")
                            .font(.title2)
                            .frame(minWidth: 300)
                            .padding(.vertical, 10)
                            .background(.blue)
                            .clipShape(Capsule())
                            .foregroundStyle(.white)
                    }
                    .disabled(isLoading)
                    
                    Spacer()
                    
                    VStack {
                        Text("Subscription is also renewable. Cancel anytime.")
                            .font(.caption)
                        
                        HStack(spacing: 20) {
                            Text("Privacy Policy")
                                .underline()
                                .onTapGesture {
                                    openURL("https://sites.google.com/view/lessphone/home")
                                }
                            Text("Terms of Use")
                                .underline()
                                .onTapGesture {
                                    openURL("https://sites.google.com/view/terms-lessphone/home")
                                }
                            Text("Info")
                                .onTapGesture {
                                    openURL("https://sites.google.com/view/subscription-info/home")
                                }
                                .underline()
                        }
                        .font(.caption2)
                    }
                    .padding(.top, 5)
                }
                
                if shouldShowProgressView {
                    Color.black
                        .opacity(0.8)
                        .blur(radius: 3.0)
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .scaleEffect(3)
                }
            }
        }
        .foregroundStyle(.white)
        .background(.black)
        .edgesIgnoringSafeArea(.all)
        .task {
            await store.updateCustomerProductStatus()
            
            if !store.purchasedLifetime && store.purchasedSubscriptions.isEmpty {
                errorMessage = "Your subscription has expired. Please renew to continue enjoying premium features."
            }
            selectedPlan = PlanType.yearly.rawValue
        }
    }
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func planButton(title: String, subtitle: String? = nil, plan: PlanType, imageName: String? = nil) -> some View {
        HStack {
            if selectedPlan == plan.rawValue {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
                    .background(.white)
                    .clipShape(Circle())
                    .padding(.leading)
            } else {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 3))
                    .frame(width: 20)
                    .foregroundColor(.blue)
                    .padding(.leading)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.title2)
                    .bold()
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                }
            }
            .padding(.vertical, 5)
            .padding(.leading)
            
            Spacer()
            
            if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .padding(.trailing)
            }
        }
        .clipShape(Capsule())
        .overlay {
            Capsule().stroke(.blue, lineWidth: 3)
        }
        .onTapGesture {
            selectedPlan = plan.rawValue
        }
    }
    
    @MainActor
    func handlePurchase() async {
        guard let product = store.lifetime.first(where: { $0.id == selectedPlan }) ??
                store.subscriptions.first(where: { $0.id == selectedPlan }) else {
            errorMessage = "Selected product not found."
            return
        }
        
        shouldShowProgressView = true
        
        do {
            let transaction = try await store.purchased(product)
            if transaction != nil {
                await store.updateCustomerProductStatus()
                await updateSubscriptionStatus()
                dismiss()
            }
        } catch {
            errorMessage = "Purchase failed. Please try again."
        }
        
        shouldShowProgressView = false
    }
    
    @MainActor
    func updateSubscriptionStatus() async {
        subscribed = store.subscriptionGroupStatus == .subscribed || store.subscriptionGroupStatus == .inGracePeriod || store.purchasedLifetime
    }
}

#Preview {
    SubscriptionView()
}
