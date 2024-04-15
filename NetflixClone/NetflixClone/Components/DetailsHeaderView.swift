//
//  DetailsHeaderView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

struct DetailsHeaderView: View {
    
    var imageName: String = Constants.randomImage
    var progress: Double = 0.2
    var onAirPlayPressed: (() -> Void)? = nil
    var onAirXMarkPressed: (()->Void)? = nil
    
    var body: some View {
        
        
        ZStack(alignment: .bottom){
            ImageLoaderView(urlString: imageName)
                .frame(maxWidth: .infinity)
            
            CustomProgressBar(
                selection: progress,
                range: 0...1,
                backgroundColor: .netflixLightGray,
                foregroundColor: .netflixRed,
                cornerRadius: 2,
                height: 6
            )
            .padding(.vertical, 4)
            .animation(.linear, value: progress)
            
            HStack(spacing: 8){
                Circle()
                    .fill(.netflixDarkGray)
                    .overlay(
                        Image(systemName:"tv.badge.wifi")
                            .offset(y: 1)
                    )
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                        onAirPlayPressed?()
                    }
                
                Circle()
                    .fill(.netflixDarkGray)
                    .overlay(
                        Image(systemName:"xmark")
                            .offset(y: 1)
                    )
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                        onAirXMarkPressed?()
                    }
            }
            .foregroundStyle(.netflixWhite)
            .font(.subheadline)
            .fontWeight(.bold)
            .padding(8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .aspectRatio(2, contentMode: .fit)
    }
}

#Preview {
    DetailsHeaderView()
}
