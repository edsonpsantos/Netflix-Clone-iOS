//
//  DataBaseHelper.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import Foundation

struct DataBaseHelper {
    
    func getMovies() async throws -> [Product] {
        
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let movies = try JSONDecoder().decode(MovieArray.self, from: data)
        return movies.products
    }
    
}  
