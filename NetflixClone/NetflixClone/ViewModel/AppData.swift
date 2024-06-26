//
//  AppData.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

@Observable
class AppData {
    var isSplashFinished: Bool = false
    var activeTab: TabBar = .home
    
    //Profile select property
    var tabProfileRectangle: CGRect = .zero
    var watchingProfile: Profile?
    var animateProfile: Bool = false
    var showProfileView: Bool = false
}
