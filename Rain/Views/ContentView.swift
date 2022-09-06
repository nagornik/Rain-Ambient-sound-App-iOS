//
//  ButtonsView.swift
//  Rain
//
//  Created by Anton Nagornyi on 03.09.2022.
//

import SwiftUI

struct ButtonsView: View {
    
    @EnvironmentObject var player: AudioManager
    @AppStorage("showHints") var showHints = true
    @State var hints = true
    
    init() {
        hints = showHints
    }
    
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
            
            VStack {
                
                Spacer()
                
                HStack {
                    Image(systemName: "speaker.wave.1")
                    
                    Slider(value: $player.soundLevel, in: 0...1)
                    
                    Image(systemName: "speaker.wave.3")
                }
                .padding()
                .tint(.white)
                .foregroundColor(Color(hex: "#B2B2B3"))
                
            }
            .offset(y: player.playingButton != nil ? 0 : 100)
            
            hintsScreen
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.spring().speed(0.3), value: player.playingButton)
        .animation(.spring().speed(0.3), value: hints)
        
    }
    
    var hintsScreen: some View {
        
        ZStack {
            
            Color.black.opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 0.0) {
                
                
                HStack(spacing: 6.0) {
                    Text("Long press")
                            .font(.system(.title, design: .rounded))
                            .padding(.top)
                            .gradientForeground(colors: [Color(hex: "#EF1689"), Color(hex: "#2F22F3")])
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 10)
                    Text("a button")
                            .font(.system(.title, design: .rounded))
                            .padding(.top)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 10)
                }
                
                HStack(spacing: 8) {
                    Text("To turn on the")
                        .font(.system(.title, design: .rounded))
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 10)
                    Text("SOUND")
                        .bold()
                        .font(.system(.title, design: .rounded))
                        .gradientForeground(colors: [Color(hex: "#EF1689"), Color(hex: "#2F22F3")])
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 10)
                }
                .padding(.bottom)
                
                Image(systemName: "arrow.turn.right.down")
                    .font(Font.title.weight(.medium))
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 10)
                
                Spacer()
                
                VStack(spacing: 16) {
                  
                    Button {
                        hints = false
                    } label: {
                        Text("Hide hints")
                            .bold()
                            .font(.system(.title, design: .rounded))
                            .padding()
                            .padding(.horizontal)
                            .background(
                                LinearGradient(colors: [Color(hex: "#EF1689"), Color(hex: "#2F22F3")], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .opacity(0.7)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .shadow(color: Color(hex: "#2F22F3"), radius: 10, x: 0, y: 5)
                    }
                    
                    Button {
                        showHints = false
                        hints = false
                    } label: {
                        Text("Don't show again")
                            .fontWeight(.medium)
                            .font(.system(.caption2, design: .rounded))
                            .padding(14)
                            .background(
                                LinearGradient(colors: [Color(hex: "#EF1689"), Color(hex: "#2F22F3")], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .opacity(0.7)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .shadow(color: Color(hex: "#EF1689"), radius: 10, x: 0, y: 5)
                    }
                    
                }
                .padding()
                
            }
            .foregroundColor(.white)
            
        }
        .offset(x: hints ? 0 : -UIScreen.main.bounds.width)
        .opacity(hints ? 1 : 0)
        
    }
    
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
            .environmentObject(AudioManager())
            .previewDevice("iPhone 13")
    }
}


