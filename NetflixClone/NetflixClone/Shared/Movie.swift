//
//  Movis.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import Foundation

struct MovieArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let brand, category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    static var mockProduct: Product{
        Product(
            id: 1,
            title: "Example product title",
            description: "Some mock description about this product",
            brand: "Apple",
            category: "Electronic devices",
            thumbnail: Constants.randomImage,
            images: [Constants.randomImage,Constants.randomImage,Constants.randomImage]
        )
    }
}

struct MovieRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
