//
//  Profile.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 16/04/2024.
//

import SwiftUI

struct Profile: Identifiable {
    
    var id: UUID = .init()
    var name: String
    var imageName: String
    
    var sourceAnchorID: String {
        return id.uuidString + "SOURCE"
    }
    
    var destinationAnchorID: String {
        return id.uuidString + "DESTINATION"
    }
}

var mockProfiles:[Profile] = [

    .init(name: "Sheldon", imageName: "DrCooper"),
    .init(name: "Amy", imageName: "DraFowler")
]


