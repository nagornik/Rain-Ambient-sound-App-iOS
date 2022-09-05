//
//  ButtonsView.swift
//  Rain
//
//  Created by Anton Nagornyi on 03.09.2022.
//

import SwiftUI

struct ButtonsView: View {
    
    @EnvironmentObject var player: AudioManager
    
    var body: some View {
        
        ZStack {
            
            Color(hex: "CED4DA")
                .ignoresSafeArea()
            
            VStack(spacing: 30.0) {
            
                ForEach(Sounds.allCases, id:\.self) { soundCase in
                    ButtonElement(buttonCase: soundCase) {
                        player.startPlayer(track: soundCase.rawValue)
                    } actionStop: {
                        player.stop()
                    }
                }

            }
            
            if player.isPlaying {
            
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "speaker.wave.1")
                        
//                        Slider(value: $player.player.volume, in: 0...1)
                        Slider(value: $player.soundLevel, in: 0...1)
                        
                        Image(systemName: "speaker.wave.3")
                    }
                    .padding()
                    .tint(.white)
                    .foregroundColor(Color(hex: "#B2B2B3"))

                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.spring().speed(0.3), value: player.isPlaying)
        
        
        
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
            .environmentObject(AudioManager())
            .previewDevice("iPhone 13")
    }
}
