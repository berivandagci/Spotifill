//
//  DatabaseHelper.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import Foundation

struct DatabaseHelper {
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let welcome = try JSONDecoder().decode(ProductWelcome.self, from: data)
        
        return welcome.products
    }
    func getUsers() async throws -> [User] {
            guard let url = URL(string: "https://dummyjson.com/users") else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let welcome = try JSONDecoder().decode(UserWelcome.self, from: data)
            
            return welcome.users
        }
    }




