//
//  DetailsView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI
import SwiftfulRouting

struct DetailsView: View {
    
    var movie: Product = .mockProduct
    @Environment(\.router) var router
    
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var movieRows: [Product] = []

    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0){
                DetailsHeaderView(
                    imageName: movie.firstImage,
                    progress: progress,
                    onAirPlayPressed: {
                        
                    },
                    onAirXMarkPressed: {
                        router.dismissScreen()
                    }
                )
                
                ScrollView(.vertical){
                    VStack(alignment: .leading, spacing: 16){
               
                        detailsMoviesSection
                        
                        buttonsSection

                        moviesGridSection
                       
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getMovies()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var buttonsSection: some View{
        HStack(spacing: 32){
            MyListButtons(
                isMyList: isMyList) {
                    isMyList.toggle()
                }
            Spacer()

            RateButton { selection in
                //To do something with this Rate Button
            }
            Spacer()

            ShareButton()
            
            Spacer()

        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 32)
    }
    
    private var moviesGridSection: some View{
        VStack(alignment: .leading){
            Text("More like this")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
                      alignment: .center,
                      spacing: 8,
                      pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
                      content: {
                ForEach(movieRows){ movie in
                    MovieCell(
                        imageName: movie.firstImage,
                        title: movie.title,
                        isRecentelyAdded: movie.recentelyAdded,
                        topTenRanking: nil
                    )
                    .onTapGesture {
                        onMoviePressed(movie: movie)
                    }
                }
            })
        }
        .foregroundStyle(.netflixWhite)
    }
    
    private var detailsMoviesSection: some View{
        MovieDetailsView(
            title: movie.title,
            isNew: true,
            yearReleased: "2024",
            seasonCount: 8,
            hasClosedCaptions: true,
            isTopten: 6,
            descriptionMovie: movie.description,
            castMovie: "Cast: Eddie Murphy, Jack Black, Chris Rock, John Doe",
            onPlayPressed: {},
            onDownloadPressed: {}
        )
    }
    
    
    private func onMoviePressed(movie: Product){
        router.showScreen(.sheet){ _ in
            DetailsView(movie: movie)
        }
    }
    
    
    private func getMovies() async {
        guard movieRows.isEmpty else { return }
        
        do{
            movieRows = try await DataBaseHelper().getMovies()
        }
        catch{}
    }
}

#Preview {
    RouterView{ _ in 
        DetailsView()
    }
}
