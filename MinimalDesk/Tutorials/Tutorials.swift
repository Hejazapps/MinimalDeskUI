import SwiftUI
import Photos
import _AVKit_SwiftUI

struct Tutorials: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isSetupTutorialsPresented: Bool = false
    @State private var activeCard: Int? = 0
    @State private var player: AVPlayer?
    @State private var selectedMedia: MediaContent?
    @State private var showToast = false
    @State private var toastMessage = ""
    let totalHeight = UIScreen.main.bounds.height
    let totalWidth = UIScreen.main.bounds.width
    
    var divider: some View {
        Divider()
            .frame(height: 1)
            .background(Color.white.opacity(0.8))
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                // MARK: Header
                VStack(spacing: 0) {
                    Text("Set Up Guide")
                        .font(.system(size: 24))
                        .bold()
                        .padding(10)
                }
                .padding(.horizontal, 25)
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack {
                            Text("Follow these steps to make your phone minimalistic")
                                .font(.system(size: 20))
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom, 20)
                        
                        showGuide(type: .wallpaper)
                        showGuide(type: .widget)
                        showGuide(type: .darkMode)
                        showGuide(type: .minimalist)
                        showGuide(type: .reduceAnimation)
                    }
                    .scrollIndicators(.never)
                }
                
                Spacer()
            }
            
            if showToast {
                ToastView(message: toastMessage)
                    .onAppear {
                        handleToast()
                    }
            }
        }
        .foregroundStyle(.white)
        .sheet(item: $selectedMedia) { media in
            FullScreenMediaView(media: media, onDismiss: { selectedMedia = nil })
        }
    }
    
    //    private func loadVideo(of type: TutorialType) {
    //        if let videoURL = Bundle.main.url(forResource: type.videoName, withExtension: type.videoType) {
    //            player = AVPlayer(url: videoURL)
    //        }
    //    }
    
    //    private func loadVideo(of type: TutorialType) {
    //        let tag = "tutorial-videos"
    //        let request = NSBundleResourceRequest(tags: [tag])
    //        request.beginAccessingResources { error in
    //            if let error = error {
    //                print("Failed to load ODR resources: \(error)")
    //                return
    //            }
    //
    //            if let videoURL = Bundle.main.url(forResource: type.videoName, withExtension: type.videoType) {
    //                DispatchQueue.main.async {
    //                    player = AVPlayer(url: videoURL)
    //                }
    //            } else {
    //                print("Video not found in ODR bundle.")
    //            }
    //        }
    //    }
    
    private func loadVideo(of type: TutorialType) {
        // Reset player before loading new video
        self.player = nil
        
        VideoLoader.shared.loadVideo(for: type) { loadedPlayer in
            DispatchQueue.main.async {
                if let player = loadedPlayer {
                    self.player = player
                    self.selectedMedia = .video(player: player)
                    print("Video loaded successfully for type: \(type.videoName).\(type.videoType)")
                } else {
                    print("Failed to load video for \(type.videoName).\(type.videoType)")
                    self.toastMessage = "Failed to load video."
                    self.showToast = true
                }
            }
        }
    }
    
    
    private func circleWithNumberView(_ number: String) -> some View {
        Text(number)
            .frame(width: 25, height: 25)
            .background(Color.gray.opacity(0.6))
            .clipShape(Circle())
            .padding(.leading, 10)
    }
    
    private func cardView(for index: Int, of type: TutorialType) -> some View {
        VStack {
            HStack {
                if index == 0 {
                    circleView(with: nil, of: type)
                } else {
                    circleView(with: index, of: type)
                }
                Text(type.instructions[index])
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 15))
            }
            VStack(spacing: 0) {
                if index == 0 {
                    ZStack {
                        Image("\(type.thumbnail)")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(7)
                            .foregroundStyle(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .onTapGesture {
                                // Reset player before loading new video
                                self.player = nil
                                loadVideo(of: type)
                            }
                        Image(systemName: "play.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .onTapGesture {
                                // Reset player before loading new video
                                self.player = nil
                                loadVideo(of: type)
                            }
                    }
                } else {
                    if type == .wallpaper && index == 1 {
                        VStack {
                            getWallpaper(of: "darkWallpaper", with: "dark")
                            getWallpaper(of: "lightWallpaper", with: "light")
                        }
                    } else {
                        Image("\(type.imageName)\(index)")
                            .resizable()
                            .scaledToFit()
                            .onTapGesture {
                                selectedMedia = .image(name: "\(type.imageName)\(index)")
                            }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .frame(width: totalWidth * 0.8)
        .padding(16)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(15)
        .padding(10)
    }
    
    //    private func pagination(type: TutorialType) -> some View {
    //        VStack {
    //            ScrollView(.horizontal, showsIndicators: false) {
    //                HStack(spacing: 0) {
    //                    ForEach(0..<type.numberOfCards, id: \.self) { index in
    //                        cardView(for: index, of: type)
    //                    }
    //                }
    //                divider
    //            }
    //            .ignoresSafeArea()
    //            .scrollTargetLayout()
    //            .scrollBounceBehavior(.basedOnSize)
    //            .scrollTargetBehavior(.viewAligned)
    //            .scrollPosition(id: $activeCard)
    //            .scrollIndicators(.never)
    //        }
    //        .frame(height: totalHeight * 0.4)
    //        .onAppear {
    //            activeCard = 0
    //            loadVideo(of: type)
    //        }
    //    }
    
    private func pagination(type: TutorialType) -> some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0..<type.numberOfCards, id: \.self) { index in
                        cardView(for: index, of: type)
                    }
                }
                divider
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollBounceBehavior(.basedOnSize)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeCard)
            .scrollIndicators(.never)
        }
        .frame(height: totalHeight * 0.4)
        .onAppear {
            activeCard = 0 // Only set the active card, do not load video here
        }
    }
    
    private func getWallpaper(of name: String, with mode: String) -> some View {
        ZStack {
            Image(name)
                .resizable()
                .cornerRadius(7)
                .padding(5)
                .frame(width: screenWidth * 0.70)
                .onTapGesture {
                    selectedMedia = .image(name: name)
                }
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Less Phone")
                        .bold()
                        .foregroundStyle( mode == "dark" ? Color.white : Color.black)
                        .font(.system(size: 16))
                    Text("For \(mode.capitalized) Mode")
                        .font(.system(size: 12))
                        .foregroundStyle(mode == "dark" ? Color.white : Color.black)
                }
                Spacer()
                Button(action: {
                    saveImageToGallery(imageName: name)
                    handleToast()
                }) {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.white)
                            .opacity(0.8)
                            .frame(width: 13, height: 13)
                        Text("Save")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 13))
                    }
                    .padding(8)
                    .background(Color.blue)
                }
                .cornerRadius(4)
            }
            .frame(width: screenWidth * 0.60, height: 100, alignment: .bottom)
            .padding(10)
        }
    }
    
    private func saveImageToGallery(imageName: String) {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    saveImage(imageName: imageName)
                } else {
                    toastMessage = "Permission denied. Enable access in settings."
                    showToast = true
                }
            }
        } else if status == .authorized || status == .limited {
            saveImage(imageName: imageName)
        } else {
            toastMessage = "Permission denied. Enable access in settings."
            showToast = true
        }
    }
    
    private func saveImage(imageName: String) {
        //let imageName = "darkWallpaper"
        guard let image = UIImage(named: imageName) else {
            toastMessage = "Image \(imageName) not found!"
            showToast = true
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        toastMessage = "Image saved to gallery!"
        showToast = true
    }
    
    private func showGuide(type: TutorialType) -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    circleWithNumberView(type.typeNumber)
                    Text(type.lowerGuideText)
                        .font(.system(size: 30))
                        .bold()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                Text(type.lowerGuideSubText)
                    .padding(.leading, 43)
            }
            pagination(type: type)
        }
    }
    
    private func circleView(with number: Int?, of type: TutorialType) -> some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 1.5)
                .frame(width: 15, height: 15)
            if let number {
                Text("\(number)")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .bold()
            } else {
                Image(systemName: "play.fill")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .onTapGesture {
                        loadVideo(of: type)
                        selectedMedia = .video(player: player!)
                    }
            }
        }
    }
    
    
    
    private func handleToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showToast = false
        }
    }
}

struct FullScreenMediaView: View {
    let media: MediaContent
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button(action: onDismiss) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)
                    .padding(.trailing, 20)
                }
                Spacer()
            }
            .zIndex(1)
            
            VStack {
                Spacer(minLength: 50)
                
                switch media {
                case .video(let player):
                    VideoPlayer(player: player)
                        .edgesIgnoringSafeArea(.horizontal)
                        .onAppear { player.play() }
                        .onDisappear { player.pause() }
                case .image(let name):
                    Image(name)
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 50)
                        .padding(.horizontal, 20)
                }
                Spacer()
            }
        }
    }
}

struct Tutorials_Previews: PreviewProvider {
    static var previews: some View {
        Tutorials()
    }
}

import AVKit
import Foundation

class VideoLoader {
    static let shared = VideoLoader()
    
    private init() {}
    
    func loadVideo(for type: TutorialType, completion: @escaping (AVPlayer?) -> Void) {
        let tag = "tutorial-videos"
        let request = NSBundleResourceRequest(tags: [tag])
        
        request.beginAccessingResources { error in
            if let error = error {
                print("ODR loading failed: \(error)")
                completion(nil)
                return
            }
            
            if let url = Bundle.main.url(forResource: type.videoName, withExtension: type.videoType) {
                let player = AVPlayer(url: url)
                DispatchQueue.main.async {
                    completion(player)
                }
            } else {
                print("Video not found for \(type.videoName).\(type.videoType)")
                completion(nil)
            }
        }
    }
}
