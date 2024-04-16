//
//  ImageLoader.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 16/04/2024.
//

import SwiftUI

struct ImageLoader: View {
    @State private var isLoading: Bool = false
    
    var body: some View {
        Circle()
            .stroke(
                .linearGradient(
                    colors: [
                        .netflixDarkRed,
                        .netflixDarkRed,
                        .netflixDarkRed,
                        .netflixDarkRed,
                        .netflixDarkRed.opacity(0.5),
                        .netflixDarkRed.opacity(0.3),
                        .netflixDarkRed.opacity(0.1),
                        .clear
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ), lineWidth:  4
            )
            .rotationEffect(.init(degrees: isLoading ? 360 : 0))
            .onAppear{
                withAnimation(.linear(duration: 0.8).repeatForever(autoreverses: false)){
                    isLoading = true
                }
            }
    }
}

#Preview {
    
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        ImageLoader()
            .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
    }
}
