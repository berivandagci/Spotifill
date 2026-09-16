//
//  ContentView.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting 
import SwiftfulRecursiveUI

struct ContentView: View {
    @Environment(\.router) var router
    
    var body: some View {
        List {
            Button("OPEN SPOTIFY") {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
