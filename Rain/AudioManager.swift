//
//  AudioManager.swift
//  Meditation
//
//  Created by Anton Nagornyi on 25.07.2022.
//

import Foundation
import AVKit

final class AudioManager: ObservableObject {
    
    var player: AVAudioPlayer?
    
    @Published private(set) var isPlaying = false
//    @Published var volume: CGFloat = 0.5
    
    func startPlayer(track: String) {
        
        guard let url = Bundle.main.url(forResource: track, withExtension: "wav") else { return }
        
        do {
            isPlaying = true
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            player?.numberOfLoops = -1
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
//    func playPause() {
//        guard let player = player else { return }
//        if player.isPlaying {
//            player.pause()
//            isPlaying = false
//        } else {
//            player.play()
//            isPlaying = true
//        }
//    }
    
    func stop() {
        guard let player = player else {
            return
        }

        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }
    
//    func toggleLoop() {
//        guard let player = player else {
//            return
//        }
//        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
//    }
    
}
