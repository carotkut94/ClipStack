//
//  ClipStackApp.swift
//  ClipStack
//
//  Created by Deathcode on 18/09/23.
//

import SwiftUI

@main
struct ClipStackApp: App {
    var body: some Scene {
            MenuBarExtra("ClipStack", systemImage: "paperclip.circle.fill") {
                ContentView()
                    .cornerRadius(16)
                    .badge(12)
                    .frame(width: 340, height: 380)
                    .ignoresSafeArea()
            }
            .menuBarExtraStyle(.window)
        }
}
