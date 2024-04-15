//
//  DetailsMoviesView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    
    var title: String = "Movie Title"
    var isNew: Bool = true
    var yearReleased: String? = "2024"
    var seasonCount: Int? = 4
    var hasClosedCaptions: Bool = true
    var isTopten: Int? = 6
    var descriptionMovie: String? = "Description for the movie e etc, Lorem iposlum dolor set met"
    var castMovie: String? = "Cast: Eddie Murphy, Woody Allen, Sean Connor, and Me"
    
    var onPlayPressed: (()-> Void)? = nil
    var onDownloadPressed: (()-> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8){
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)
                }
                
                if let yearReleased {
                    Text(yearReleased)
                }
                
                if let seasonCount {
                    Text("\(seasonCount) Seasons")
                }
                
                if hasClosedCaptions{
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)
            
            
            if let isTopten{
                HStack(spacing: 8){
                    topTenIcon
                    
                    Text("\(isTopten) in TV Shows Today")
                        .font(.headline)
                }
            }
            
            buttonsDetailsMoviesView
            
            Group{
                if let descriptionMovie {
                    Text(descriptionMovie)
                }
                
                if let castMovie {
                    Text(castMovie)
                        .foregroundStyle(.netflixLightGray)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            
        }
        .foregroundStyle(.netflixWhite)
    }
    
    private var buttonsDetailsMoviesView: some View{
        HStack(spacing: 8) {
            HStack{
                Image(systemName: "play.fill")
                Text("Play")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .foregroundStyle(.netflixDarkGray)
            .background(
                Color.white
            )
            .cornerRadius(6)
            .asButton(.press) {
                onPlayPressed?()
            }

        
            HStack{
                Image(systemName: "arrow.down.to.line.alt")
                Text("Download")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .foregroundStyle(.netflixWhite)
            .background(
                Color.netflixDarkGray
            )
            .cornerRadius(6)
            .asButton(.press) {
                onDownloadPressed?()
            }
        }
        .font(.callout)
        .fontWeight(.medium)
    }
    
    private var topTenIcon: some View{
        Rectangle()
            .fill(.netflixRed)
            .frame(width: 28, height: 28)
            .overlay(
                VStack(spacing: -3){
                    Text("Top").textCase(.uppercase)
                        .fontWeight(.bold)
                        .font(.system(size: 8))
                    
                    Text("10")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
                    .offset(y:1)
            )
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        VStack(spacing: 40) {
            MovieDetailsView()
            MovieDetailsView(
                isNew: false,
                yearReleased: nil,
                seasonCount: nil,
                hasClosedCaptions: false,
                isTopten: nil,
                descriptionMovie: nil,
                castMovie: nil
                
            )
        }
    }
}
