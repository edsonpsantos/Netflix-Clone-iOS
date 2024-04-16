//
//  SplashScreen.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI
import Lottie

struct SplashScreen: View {
    
    @Environment(AppData.self) private var appData
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        
        Rectangle()
            .fill(.netflixBlack)
            .ignoresSafeArea()
            .overlay{
                if let jsonURL {
                    LottieView{
                        await LottieAnimation.loadedFrom(url: jsonURL)
                    }
                    .playing(.fromProgress(0, toProgress: progress, loopMode: .playOnce))
                    .animationDidFinish { completed in
                        appData.isSplashFinished = progress != 0 && completed
                        appData.showProfileView = appData.isSplashFinished
                    }
                    .frame(width: 600, height: 400)
                    .task {
                        try? await Task.sleep(for: .seconds(0.2))
                        progress = 0.8
                    }
                }
            }
    }
    
    private var jsonURL: URL? {
        if let bundlePath = Bundle.main.path(forResource: "logo", ofType: "json") {
            return URL(filePath: bundlePath)
        }
        return nil
    }
}

#Preview {
    ZStack{
        
        Color.netflixBlack.ignoresSafeArea()
        
        ContentView()
    }
}
