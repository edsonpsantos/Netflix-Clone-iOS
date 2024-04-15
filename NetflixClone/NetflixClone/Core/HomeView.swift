//
//  HomeView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var filter = FilterModel.mockArray
    @State private var seletedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    
    @State private var heroMovie: Product? = nil
    @State private var movieRows:[MovieRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 8){
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroMovie {
                        heroCell(heroMovie: heroMovie)
                    }
                    
                    categoryRows
                }
            }
            .scrollIndicators(.hidden)
            
            VStack(spacing: 0){
                header
                    .padding(.horizontal, 16)
                
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
            }
            .background(Color.blue)
            .readingFrame { frame in
                fullHeaderSize = frame.size
            }
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
            
            //Set to garantee that no duplicate brands\rows
            let allBrands = Set(movies.map({ $0.brand }))
            for brand in allBrands {
                rows.append(MovieRow(title: brand.capitalized, products: movies))
            }
            movieRows = rows
        }
        catch{}
    }
    
    
    private var header: some View{
        HStack(spacing: 0){
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
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
                
            },
            onPlayPressed: {
                
            },
            onMyListPressed: {
                
            }
        )
        .padding(24)
    }
}

#Preview {
    HomeView()
}
