//
//  NetflixCloneApp.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import SwiftUI

@main
struct NetflixCloneApp: App {
    
    var appData: AppData = AppData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appData)
        }
    }
}
