import SwiftUI
import AlertToast
import Reachability
import WidgetKit

struct AppListView: View {
    @ObservedObject private var viewModel: FirebaseDataViewModel
    @Environment(\.dismiss) var dismiss
    @State var showCancelButton = false
    @State var showToast =  false
    
    @State var widthToSet: CGFloat = 0
    @State var heightToSet: CGFloat = 0
    @State var gap: CGFloat = 0
    @State private var searchText = ""
    @State private var selectedIndices: Set<String> = []
    private var cardIndex: Int = 0
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return viewModel.onlyAppName
        } else {
            return viewModel.onlyAppName.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
        
    init(viewModel: FirebaseDataViewModel, cardIndex: Int = 0) {
        log("IN")
        
        self.viewModel = viewModel
        self.cardIndex = cardIndex
        
        if viewModel.appList.isEmpty {
            viewModel.prepareAppList()
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                backButton()
                
                VStack(spacing: 5) {
                    pageTitle()
                    
                    guideText()
                    
                    searchBar()
                }
                
                appList()
                
                Spacer()
                
                doneButton()
            }
            
            if showToast {
                ToastView(message: "Max 6 apps can be selected")
            }
        }
        .foregroundColor(.gray)
    }
}

//MARK: - SubViews
private extension AppListView {
    func backButton() -> some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image("Back")
                    .resizable()
                    .frame(width: 60, height: 60)
            }
            
            Spacer()
        }
        .padding(.leading,15)
    }
    
    func pageTitle() -> some View {
        HStack {
            Spacer()
            Text("Add Favorite Apps")
                .font(.title)
                .bold()
                .foregroundColor(Color.white)
            Spacer()
        }
    }
    
    func guideText() -> some View {
        HStack {
            Spacer()
            
            Text("Pick your top 6 frequently used apps to keep on your home screen for easy access, avoiding clutter and distractions.")
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
    
    func searchBar() -> some View {
        TextField(
            "",
            text: $searchText,
            prompt: Text("Search")
                .foregroundColor(Color(rgbRed: 137, green: 137, blue: 137))
        )
        .padding(.all, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(rgbRed: 28, green: 28, blue: 28))
        )
        .foregroundColor(.white)
        .padding([.top, .horizontal])
    }
    
    func appList() -> some View {
        List(searchResults, id: \.self) { name in
            HStack {
                Text(name)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                if self.selectedIndices.contains(name) {
                    Image("right")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 16)
                }
            }
            .padding()
            .listRowInsets(EdgeInsets()) // Remove default padding
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .listRowBackground(Color.black)
            .contentShape(Rectangle())
            .onTapGesture {
                onSelectingApp(name)
            }
        }
        .listStyle(.plain)
        .background(.black)
        .scrollContentBackground(.hidden)
        .onAppear {
            doOnAppear(with: cardIndex)
        }
    }
    
    func doneButton() -> some View {
        HStack {
            Text("Done")
                .padding(.vertical, 5)
                .padding(.horizontal, screenWidth / 3)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical, 3)
                .foregroundColor(.black)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.saveFavoriteApps(in: selectedIndices, for: cardIndex)
                    if cardIndex == viewModel.cards {
                        viewModel.cards += 1
                        UserDefaults.standard.set(viewModel.cards, forKey: UserDefaultsKeys.numberOfFavAppList.rawValue)
                    }
                    dismiss()
                }
        }
    }
}

// MARK: - Utility Functions
private extension AppListView {
    func doOnAppear(with cardIndex: Int = 0) {
        guard viewModel.favApps[cardIndex].isEmpty else {
            viewModel.favApps[cardIndex].forEach { app in
                selectedIndices.insert(app["name"] ?? "Nil")
            }
            
            return
        }
        
        let lim = min(6, viewModel.appList.count)
        viewModel.appList[0..<lim].forEach { app in
            selectedIndices.insert(app.appName)
        }
    }
    
    func onSelectingApp(_ name: String) {
        if selectedIndices.contains(name) {
            selectedIndices.remove(name)
        } else {
            if selectedIndices.count < 6 {
                selectedIndices.insert(name)
            }
            else {
                showToast = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showToast = false
                }
            }
        }
        
        log(selectedIndices)
    }
}

#Preview {
    AppListView(viewModel: FirebaseDataViewModel.shared)
}
