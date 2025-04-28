import SwiftUI

struct AppIconsView: View {
    @Environment(\.dismiss) var dismiss
    
    private let images = (1...6).map { "App logo \($0)" }
    
    @Binding var appIcon: String
    @State private var selectedIcon = "App logo 2"
    @State private var showConfirmationAlert = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding()
                    .opacity(0.8)
                    .foregroundStyle(Color.white)
                    .onTapGesture {
                        if selectedIcon != UserDefaults.standard.string(forKey: UserDefaultsKeys.currentAppIcon.rawValue) {
                            showConfirmationAlert = true
                        } else {
                            dismiss()
                        }
                    }
            }
            .frame(width: UIScreen.main.bounds.width * 0.95)
            
            Image(selectedIcon)
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
                .frame(width: 100, height: 100)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                .padding(.leading, 25)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .frame(height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        imageName == selectedIcon ? Color.blue : Color.clear,
                                        lineWidth: 3
                                    )
                            )
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            .onTapGesture {
                                selectedIcon = imageName
                            }
                    }
                }
                .padding()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .alert("Change App Icon?", isPresented: $showConfirmationAlert) {
            Button("Yes") {
                setAppIcon(name: changeName(from: selectedIcon)) {
                    dismiss()
                }
            }
            Button("No", role: .cancel) { dismiss() }
        } message: {
            Text("Are you sure you want to change the app icon?")
        }
        .onAppear {
            selectedIcon = UserDefaults.standard.string(forKey: UserDefaultsKeys.currentAppIcon.rawValue) ?? "App logo 2"
            UserDefaults.standard.set(selectedIcon, forKey: UserDefaultsKeys.currentAppIcon.rawValue)
        }
    }
    
    private func setAppIcon(name: String?, completion: @escaping () -> Void) {
        UIApplication.shared.setAlternateIconName(name) { error in
            if let error = error {
                print("Failed to set alternate icon: \(error.localizedDescription)")
            } else {
                print("App icon successfully changed to: \(name ?? "default")")
                UserDefaults.standard.set(selectedIcon, forKey: UserDefaultsKeys.currentAppIcon.rawValue)
                appIcon = selectedIcon
            }
            completion()
        }
    }
    
    private func changeName(from name: String) -> String {
        guard let index = name.last else {
            return "AppIcon"
        }
        return "AppIcon \(index)"
    }
}
