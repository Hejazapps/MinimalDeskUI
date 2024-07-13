import SwiftUI


struct AppListView: View {
    
    @ObservedObject private var viewModel: FirebaseDataViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var widthToSet: CGFloat = 0
    @State var heightToSet: CGFloat = 0
    @State var gap: CGFloat = 0
    @State private var searchText = ""

    
    init(viewModel: FirebaseDataViewModel) {
        print("[FirebaseDataView] IN")
        self.viewModel = viewModel
        viewModel.fetchAllSubscribers()
    }
    
    var body: some View {
        ZStack {
            Color(red: 25 / 255, green: 25 / 255, blue: 25 / 255).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("Back")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    Spacer()
                }
                
                VStack(spacing: 5) {
                    HStack {
                        Spacer()
                        Text("Add Favorite Apps")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("Pick your top 6 frequently used apps to keep on your home screen for easy access, avoiding clutter and distractions.")
                            .multilineTextAlignment(.center)
//                            .foregroundColor(Color(red: 142/255, green: 142/255, blue: 142/255))
                        
                        Spacer()
                    }

                    
                    TextField("Search", text: $searchText)
                        .padding([.top, .horizontal])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                List(viewModel.appList) { app in
                    Text(app.appName)
                        .listRowBackground(Color(red: 25 / 255, green: 25 / 255, blue: 25 / 255))
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .padding(.leading)
                
                Spacer()
            }
            
        }
        .foregroundColor(.gray)
    }
}
