//
//  ContentView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @Environment(\.router) var router
    
    var appData: AppData = .init()
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            
            /*
            First View after SplashScreen is loaded
            */
            HomeView()
                .transition(.move(edge: .top).combined(with: .opacity))

            if !appData.isSplashFinished {
                SplashScreen()
            }
            
        }
        .environment(appData)
    }
}

#Preview {
    ZStack{
        Color.netflixBlack.ignoresSafeArea()
        ContentView()
    }
}

