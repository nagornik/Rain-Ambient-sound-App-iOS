//
//  RainApp.swift
//  Rain
//
//  Created by Anton Nagornyi on 05.09.2022.
//

import SwiftUI

@main
struct RainApp: App {
    var body: some Scene {
        WindowGroup {
            ButtonsView()
                .environmentObject(AudioManager())
        }
    }
}
