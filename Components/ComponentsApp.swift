//
//  ComponentsApp.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import SwiftUI
import SwiftfulRouting

@main
struct ComponentsApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}
