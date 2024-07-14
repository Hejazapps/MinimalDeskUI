import SwiftUI
import AlertToast
import Reachability

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
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return viewModel.onlyAppName
        } else {
            return viewModel.onlyAppName.filter { $0.contains(searchText) }
        }
    }
    
    
    init(viewModel: FirebaseDataViewModel) {
       
        self.viewModel = viewModel
        viewModel.fetchAllSubscribers()
        
        if viewModel.appList.count < 1 {
            viewModel.getList()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if viewModel.appList.count > 0 {
                viewModel.saveUserDefault()
            }
        
        }
        
       
    }
    
    
    
    var body: some View {
        ZStack {
            Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255).edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
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
                
                
                
                
                VStack(spacing: 5) {
                    HStack {
                        Spacer()
                        Text("Add Favorite Apps")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("Pick your top 6 frequently used apps to keep on your home screen for easy access, avoiding clutter and distractions.")
                            .multilineTextAlignment(.center)
                        //                            .foregroundColor(Color(red: 142/255, green: 142/255, blue: 142/255))
                        
                        Spacer()
                    }
                    
                    
                    TextField("", text: $searchText,prompt: Text("Search").foregroundColor(Color(red: 137 / 255, green: 137 / 255, blue: 137 / 255)))
                        .padding(.all, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 28 / 255, green: 28 / 255, blue: 28 / 255))
                        )
                        .foregroundColor(.white)
                    
                        .padding([.top, .horizontal])
                    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
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
                    .background(.black)
                    .listRowInsets(EdgeInsets()) // Remove default padding
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        if selectedIndices.contains(name) {
                            selectedIndices.remove(name)
                        } else {
                            if selectedIndices.count < 6 {
                                selectedIndices.insert(name)
                            }
                            else {
                                showToast = true
                            }
                        }
                        
                        
                    }
                    
                    
                    // Ensure ZStack fills entire row
                }
                //                    .scrollContentBackground(.hidden)
                .listStyle(.plain)
                
                Spacer()
            }
            
        }
        .foregroundColor(.gray)
    }
    
    
}

#Preview {
    AppListView(viewModel: FirebaseDataViewModel())
}


struct ToastView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color.black.opacity(0.7))
                .cornerRadius(25)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .transition(.opacity)
    }
}
