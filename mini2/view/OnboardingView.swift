import SwiftUI
import AVKit

struct OnboardingView: View {
    let gameCenter = GameCenterManager.shared
    @State var character: Character = Character()
    @State private var currentFrame: Int = 0
    private let totalFrames = 45
    @State private var videoFinished = false

    var body: some View {
        NavigationStack {
            ZStack {
                if !videoFinished {
                    VideoPlayerView(onVideoFinished: {
                        videoFinished = true
                    })
                } else {
                    NavigationLink(destination: InGameView(character: $character), label: {
                        Image("onboarding_\(String(format: "%05d", currentFrame))")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .edgesIgnoringSafeArea(.all)
                    })
                }
            }
        }
        .onAppear {
            gameCenter.authenticatePlayer()
            animateFrames()
        }
    }
    
    private func animateFrames() {
        // Create a repeating timer to advance frames
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            self.currentFrame = (self.currentFrame + 1) % self.totalFrames
        }
    }
}

struct VideoPlayerView: View {
    let onVideoFinished: () -> Void
    @State private var player: AVPlayer?

    init(onVideoFinished: @escaping () -> Void) {
        self.onVideoFinished = onVideoFinished
    }

    var body: some View {
        Group {
            if let player = player {
                VideoPlayer(player: player)
                    .onAppear {
                        player.play()
                        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                            onVideoFinished()
                        }
                    }
            } else {
                Text("Loading video...")
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if player == nil, let url = Bundle.main.url(forResource: "intro", withExtension: "mp4") {
                player = AVPlayer(url: url)
                print("Video file found.")
            } else {
                print("Video file not found or player already initialized.")
            }
        }
    }
}
