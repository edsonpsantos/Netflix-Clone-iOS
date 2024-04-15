//
//  SharedButton.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

struct ShareButton: View {
    
    var url: String = "https://www.apple.com"
    
    var body: some View {
        if let url = URL(string:  url){
            ShareLink(item: url){
                VStack(spacing: 8) {
                    
                    Image(systemName: "paperplane")
                        .font(.title2)
                    
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                    
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(.netflixBlack.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack{
        Color.netflixBlack.ignoresSafeArea()
        
        ShareButton()
    }
}
