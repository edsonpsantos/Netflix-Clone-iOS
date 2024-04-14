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
    
    
    var body: some View {
        ZStack{
            Color.netflixBlack.ignoresSafeArea()
            
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
                
                Spacer()
            }
        }
        .foregroundColor(.netflixWhite)
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
}

#Preview {
    HomeView()
}
