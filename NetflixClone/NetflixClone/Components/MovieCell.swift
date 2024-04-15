//
//  MovieCell.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

struct MovieCell: View {
    
    var width: CGFloat = 90
    var height: CGFloat = 140
    var imageName: String = Constants.randomImage
    var title: String? = "Movie Title"
    var isRecentelyAdded: Bool = false
    var topTenRanking: Int? = nil
    
    var body: some View {
        HStack(alignment: .bottom, spacing: -8){
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .medium ,design: .serif))
                    .offset(y: 20)
            }
            
            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)
                VStack(spacing: 0.0) {
                    
                    if let title, let firstWord = title.components(separatedBy: " ").first {
                        Text(firstWord)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    Text("Recentely Added")
                        .padding(.horizontal,4)
                        .padding(.vertical, 2)
                        .padding(.bottom, 2)
                        .frame(maxWidth: .infinity)
                        .background(.netflixRed)
                        .cornerRadius(2)
                        .offset(y: 2)
                        .lineLimit(1)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal,8)
                        .opacity(isRecentelyAdded ? 1 : 0)
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .cornerRadius(4)
            .frame(width: width, height: height)
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()

        ScrollView(.vertical) {
            VStack {
                MovieCell(isRecentelyAdded: false, topTenRanking: 1)
                MovieCell(isRecentelyAdded: true, topTenRanking: 2)
                MovieCell(isRecentelyAdded: true, topTenRanking: 3)
                MovieCell(isRecentelyAdded: false, topTenRanking:4)
            }
        }
        
    }
}
