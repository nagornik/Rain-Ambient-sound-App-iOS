//
//  ButtonElement.swift
//  Rain
//
//  Created by Anton Nagornyi on 05.09.2022.
//

import SwiftUI

struct ButtonElement: View {
    
    @EnvironmentObject var player: AudioManager
    
    @GestureState var tap = false
    
    var buttonCase: Sounds
    var press: Bool {
        player.playingButton == buttonCase ? true : false
    }
    
    var actionStart: () -> Void
    var actionStop: () -> Void
    
    var body: some View {
        ZStack {
            Image(buttonCase.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .brightness(press ? 0.3 : 0.7)
            
            Image(buttonCase.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .brightness(0.3)
                .clipShape(
                    Rectangle()
                        .offset(y: tap ? 0 : 60)
                )
                .opacity(press ? 0 : 1)
            
        }
        .frame(width: 120, height: 120)
        .background(
            ZStack {
                LinearGradient(
                    colors: press ?
                    [Color(hex: "CED4DA"), Color(hex: "E9ECEF")]
                            :
                        [Color(hex: "E9ECEF"), Color(hex: "CED4DA")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                
                
                Circle()
                    .stroke(Color.white.opacity(0.0001), lineWidth: 10)
                    .shadow(color: Color(hex: "ADB5BD"), radius: 3, x: press ? 5 : -5, y: press ? 5 : -5)
                    .scaleEffect(1.2)

                Circle()
                    .stroke(Color.white.opacity(0.0001), lineWidth: 10)
                    .shadow(color: Color(hex: "E9ECEF"), radius: 3, x: press ? -5 : 5, y: press ? -5 : 5)
                    .scaleEffect(1.2)
            }
        )
        .clipShape(Circle())
        .overlay(content: {
            Circle()
                .trim(from: tap ? 0 : 1, to: 1)
                .stroke(LinearGradient(colors: [Color(hex: "#FC1470"), .purple], startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .frame(width: 88, height: 88)
                .rotationEffect(.degrees(90))
                .rotation3DEffect(.degrees(180), axis: (1,0,0))
                .shadow(color: Color(hex: "7324CD").opacity(0.3), radius: 5, x: 3, y: 3)
                .animation(.easeInOut, value: tap)
        })
        .shadow(color: press ? Color(hex: "ADB5BD") : Color(hex: "E9ECEF"), radius: 20, x: -20, y: -20)
        .shadow(color: press ? Color(hex: "E9ECEF") : Color(hex: "ADB5BD"), radius: 20, x: 20, y: 20)
        .scaleEffect(tap ? 1.2 : 1)
        .gesture(
            LongPressGesture()
                .updating($tap, body: { currentState, gestureState, transaction in
                    gestureState = currentState
                    impact(type: .rigid)
                })
                .onEnded({ value in
                    haptic(type: .success)
                    if player.playingButton != buttonCase {
                        player.playingButton = buttonCase
                        actionStart()
                    } else {
                        player.playingButton = nil
                        actionStop()
                    }
                })
        )
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: press)
        .animation(.easeInOut, value: tap)
        
        
        
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        ButtonElement(buttonCase: .rain, actionStart: {}, actionStop: {})
            .environmentObject(AudioManager())
            .previewDevice("iPhone 13")
    }
}
