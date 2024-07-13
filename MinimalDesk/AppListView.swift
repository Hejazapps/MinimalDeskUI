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
        VStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 5) {
              
                HStack {
                    VStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image("Back")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                    .padding(.trailing, 30)
                    
                    Spacer()
                }
                .background(Color.black)
                
                HStack {
                    Spacer()
                    Text("Add Favorite Apps")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                }
                .padding()
                .background(Color.black)
                
                HStack {
                    Spacer()
                    
                    Text("Pick your top 6 frequently used apps to keep on your home screen for easy access, avoiding clutter and distractions.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 142/255, green: 142/255, blue: 142/255))
                        
                     
                         
                    Spacer()
                }
                .padding()
                .background(Color.black)
                
                
                TextField("Search", text: $searchText)
                               .padding()
                               .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            
        }
        .background(Color.black)
    }
}
