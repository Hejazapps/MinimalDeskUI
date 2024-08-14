
import SwiftUI


struct CustomWallpaper: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.dismiss) var dismiss
    
    @State private var index: Int? = 0
    
    private let sampleTrips = [ "Mockup1",
                                "Mockup2",
                                "Mockup3",
                                "Mockup4",
                                "Mockup5",
                                "Mockup6",
                                "Mockup7",
                                "Mockup8",
                                "Mockup9",
                                "Mockup10",
                                "Mockup11"]
    
    enum GestureType {
        case left
        case right
    }
    private func changePic(forSwipeTo gestureType: GestureType, proxy: ScrollViewProxy) {
//        switch gestureType {
//        case .left:
//            guard index < sampleTrips.count - 1 else { return }
//            index += 1
//            proxy.scrollTo(sampleTrips[index])
//            
//        case .right:
//            guard index > 0 else { return }
//            index -= 1
//            proxy.scrollTo(sampleTrips[index])
//        }
    }
    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
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
                        Text("Wallpaper")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("Curated Minimalist Wallpapers That Inspire Simplicity")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(rgbRed: 153, green: 153, blue: 153))
                            .frame(width:300)
                        //                            .foregroundColor(Color(red: 142/255, green: 142/255, blue: 142/255))
                        
                        Spacer()
                    }.padding(.top,10)
                    
                    
                    HStack(spacing:10) {
                        Spacer()
                        
                        Text("Step to apply the wallpaper")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(rgbRed: 138, green: 196, blue: 75))
                        
                        Image("coloredArrow")
                            .resizable()
                            .frame(width: 20, height: 25)
                            .padding(.leading, -7)
                            .padding(.trailing,15)
                        
                        Spacer()
                        
                    }.padding(.top,20)
                    
                    HStack(spacing: 0) {
                        Image(.arrowLeft)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                guard let id = index, id > 0 else { return }
                                
                                index = id - 1
                            }
                        

                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                ForEach(0..<sampleTrips.count, id: \.self) { id in
                                    
                                    Image(sampleTrips[id])
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.horizontal, 20)
                                        .containerRelativeFrame(.horizontal)
                                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                            content
                                                .opacity(phase.isIdentity ? 1.0 : 0.8)
                                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                        }
                                }
                            }
                            .frame(maxHeight: 400)
                            .scrollTargetLayout()
                        }
                        .scrollIndicators(.hidden)
                        .scrollTargetBehavior(.paging)
                        .scrollPosition(id: $index)
                        .animation(.default, value: index)
                        .padding(.horizontal, 5)
                        
                        Image(.arrowRight)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                guard let id = index, id < sampleTrips.count - 1 else { return }
                                
                                index = id + 1
                            }
                    }
                    .padding(.horizontal, 5)
                    
                    Button("Use this Wallpaper") {
                        
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(.black)
                    
                    
                    
                    HStack(alignment: .center, spacing: 15) {
                        ForEach(0..<sampleTrips.count) { id in
                            Circle()
                                .fill()
                                .foregroundColor(id == index ? .white : .gray)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .padding(25)
                }
                
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(colorScheme == .dark ? Color.black : Color.black)
        .onAppear {
            print("it has been called")
        }
        
    }
    
}

struct CustomWallpaper_Previews: PreviewProvider {
    static var previews: some View {
        CustomWallpaper()
    }
}


extension Color {
    init(rgbRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }
}
