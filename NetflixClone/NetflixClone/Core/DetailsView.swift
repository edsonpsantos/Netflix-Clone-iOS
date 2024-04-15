//
//  DetailsView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

struct DetailsView: View {
    
    var movies: Product = .mockProduct
    
    @State private var progress: Double = 0.2
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0){
                DetailsHeaderView(
                    imageName: movies.firstImage,
                    progress: progress,
                    onAirPlayPressed: {
                        
                    },
                    onAirXMarkPressed: {
                        
                    }
                )
                
                ScrollView(.vertical){
                    VStack(spacing: 16){
                        DetailsMoviesView(
                            title: movies.title,
                            isNew: true,
                            yearReleased: "2024",
                            seasonCount: 8,
                            hasClosedCaptions: true,
                            isTopten: 6,
                            descriptionMovie: movies.description,
                            castMovie: "Cast: Eddie Murphy, Jack Black, Chris Rock, John Doe",
                            onPlayPressed: {},
                            onDownloadPressed: {}
                        )
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    DetailsView()
}
