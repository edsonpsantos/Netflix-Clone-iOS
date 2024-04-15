//
//  TabBar.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

enum TabBar: String, CaseIterable {
    case home = "Home"
    case new = "New & Hot"
    case account = "My Netflix"
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .new:
            return "play.rectangle.on.rectangle.fill"
        case .account:
            return "Profile"
        }
    }
}
