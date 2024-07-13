import SwiftUI


struct AppListView: View {
    
    @ObservedObject private var viewModel: FirebaseDataViewModel
    @Environment(\.dismiss) var dismiss
    @State var showCancelButton = false
  
    
    @State var widthToSet: CGFloat = 0
    @State var heightToSet: CGFloat = 0
    @State var gap: CGFloat = 0
    @State private var searchText = ""
    
    var searchResults: [String] {
           if searchText.isEmpty {
               return viewModel.onlyAppName
           } else {
               return viewModel.onlyAppName.filter { $0.contains(searchText) }
           }
       }
    
    
    init(viewModel: FirebaseDataViewModel) {
        print("[FirebaseDataView] IN")
        self.viewModel = viewModel
        viewModel.fetchAllSubscribers()
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
                    
                        .padding([.top, .horizontal])
                    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                List {
                    ForEach(searchResults, id: \.self) { name in
                        ZStack {
                            Color.black // Set background color directly
                            
                            HStack {
                                Text(name)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                                
                                Image("right")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 16)
                            }
                            .listRowInsets(EdgeInsets()) // Remove default padding
                            .listRowSeparator(.hidden) // Hide row separator
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure ZStack fills entire row
                    }
                }
                .background(Color.black.edgesIgnoringSafeArea(.all)) // Background color for the entire List
                .listStyle(PlainListStyle()) // Optional: Use plain list style for consistency
 
                Spacer()
            }
            
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    AppListView(viewModel: FirebaseDataViewModel())
}
