//
//  DataBaseHelper.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import Foundation

struct DataBaseHelper {
    
    func getProducts() async throws -> [Movie] {
        
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode(MovieArray.self, from: data)
        return products.movies
    }
    
    func getUsers() async throws -> [User] {
        
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(UserArray.self, from: data)
        return users.users
    }
}
