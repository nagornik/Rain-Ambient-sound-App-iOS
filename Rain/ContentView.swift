//
//  ButtonsView.swift
//  Rain
//
//  Created by Anton Nagornyi on 03.09.2022.
//

import SwiftUI

struct ButtonsView: View {
    
    @EnvironmentObject var player: AudioManager
    @State private var soundLevel: Float = 0.5
    
    var body: some View {
        
        ZStack {
            
            ButtonElement(imageName: "rain") {
                player.startPlayer(track: "rain")
            } actionStop: {
                player.stop()
            }

            if player.isPlaying {
            
                VStack {
                    
                    Spacer()
                    
                    Text("Volume")
//                        .foregroundColor(Color(hex: "#B2B2B3"))
                    
                    HStack {
                        Image(systemName: "speaker.wave.1")
                        
                        Slider(
                            value: $soundLevel, in: 0...1,
                            onEditingChanged: { data in
                                player.player?.volume = soundLevel
                            })
                        
                        
                        
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
        .background(Color(hex: "CED4DA"))
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
