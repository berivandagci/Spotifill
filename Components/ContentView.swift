//
//  ContentView.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRecursiveUI
struct ContentView: View {
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(users ){
                    user in Text(user.firstName)
                }
            }
        }
        .padding()
        .task {
            await getData()
        }
    }
    private func getData() async {
        do {
            users = try await DatabaseHelper().getUsers()
            products = try await
            DatabaseHelper().getProducts()
            
        }
        catch {
            
        }
        
    }
}
        #Preview {
            ContentView()
        }
    
