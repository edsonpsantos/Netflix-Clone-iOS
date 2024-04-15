//
//  HomeView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import SwiftUI
import SwiftfulRouting

struct HomeView: View {
    
    @Environment(\.router) var router
    
    @State private var filter = FilterModel.mockArray
    @State private var seletedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    
    @State private var heroMovie: Product? = nil
    @State private var movieRows:[MovieRow] = []
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            backgroundGradientLayer
            
            scrollViewLayer

            fullHeaderWithFilter
        }
        .foregroundColor(.netflixWhite)
        .task {
            await getMovies()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getMovies() async {
        guard movieRows.isEmpty else {return}
        do{
            let movies = try await DataBaseHelper().getMovies()
            heroMovie = movies.first
            
            var rows: [MovieRow] = []
            
            //Set to garantee that no duplicate rows
            let allBrands = Set(movies.map({ $0.brand }))
            for brand in allBrands {
                rows.append(MovieRow(title: brand.capitalized, products: movies.shuffled()))
            }
            movieRows = rows
        }
        catch{}
    }
    
    
    private func onMoviePressed(movie: Product){
        router.showScreen(.sheet){ _ in
            DetailsView(movie: movie)
        }
    }
    
    
    private var backgroundGradientLayer: some View{
        ZStack{
            LinearGradient(
                colors: [
                    .netflixDarkGray.opacity(1),
                    .netflixDarkGray.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            LinearGradient(
                colors: [
                    .netflixDarkRed.opacity(0.5),
                    .netflixDarkRed.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, (400 + (scrollViewOffset * 0.70))))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    private var scrollViewLayer: some View{
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false,
            content: {
                VStack(spacing: 8){
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroMovie {
                        heroCell(heroMovie: heroMovie)
                    }
                    
//                    Text("\(scrollViewOffset)").foregroundStyle(.red)
                    
                    categoryRows
                }
            },
            onScrollChanged: { offset in
                scrollViewOffset = min(0, offset.y)
            }
        )
    }
    
    private var fullHeaderWithFilter: some View{
        VStack(spacing: 0){
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -20 {
                FilterBarView(filters: filter,
                              selectedFilter: seletedFilter,
                              onFilterPressed: {
                    newFilter in
                    seletedFilter = newFilter
                    
                },
                  onXMarkPressed: {
                    seletedFilter = nil
                })
                .padding(.top, 16)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 12)
        .background(
            ZStack{
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero{
                fullHeaderSize = frame.size
            }
        }
    }
    
    private var header: some View{
        HStack(spacing: 0){
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            
            HStack(spacing: 16){
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
    }
    
    private var categoryRows: some View{
        LazyVStack(spacing: 16){
            ForEach(Array(movieRows.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment:.leading, spacing: 6){
                    Text(row.title)
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id: \.offset){ (index, filter) in
                                MovieCell(
                                    imageName: filter.firstImage,
                                    title: filter.title,
                                    isRecentelyAdded: filter.recentelyAdded,
                                    topTenRanking: rowIndex == 1 ? (index + 1) : nil
                                )
                                .onTapGesture {
                                    onMoviePressed(movie: filter)
                                }
                            }
                        }
                        .padding(.horizontal,16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
    private func heroCell(heroMovie: Product) -> some View {
        HeroCell(
            imageName: heroMovie.firstImage,
            isFilm: true,
            title: heroMovie.title,
            categories: [heroMovie.category.capitalized, heroMovie.brand],
            onBackgroundPressed: {
                onMoviePressed(movie: heroMovie)
            },
            onPlayPressed: {
                onMoviePressed(movie: heroMovie)
            },
            onMyListPressed: {
                onMoviePressed(movie: heroMovie)
            }
        )
        .padding(24)
    }
}

#Preview {
    RouterView{ _ in
        HomeView()
    }
}
