//
//  Sound.swift
//  mini2
//
//  Created by Raphael on 25/06/24.
//

import Foundation
import AVFoundation
import SwiftUI

class AudioManager: ObservableObject {
    private var audioPlayers: [AVAudioPlayer] = []
    
    @Published var isPlaying: Bool = false

    func loadAudioFiles(urls: [URL]) {
        audioPlayers.removeAll()
        
        for url in urls {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                audioPlayers.append(player)
            } catch {
                print("Error loading audio file: \(error)")
            }
        }
    }

    func play() {
        for player in audioPlayers {
            player.play()
        }
        isPlaying = true
    }
    
    func stop() {
        for player in audioPlayers {
            player.stop()
        }
        isPlaying = false
    }
}
