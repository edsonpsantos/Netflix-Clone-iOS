//
//  FilterBarView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import SwiftUI


struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropDown: Bool
    
    static var mockArray: [FilterModel] = [
        FilterModel(title: "Action", isDropDown: true),
        FilterModel(title: "Drama", isDropDown: false),
        FilterModel(title: "Comedy", isDropDown: false),
        FilterModel(title: "Fiction", isDropDown: false),
        FilterModel(title: "Horror", isDropDown: false),
    ]
}

struct FilterBarView: View {
    
    var filters: [FilterModel] = FilterModel.mockArray
    var selectedFilter: FilterModel? = nil
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                if selectedFilter != nil{
                    Image(systemName:"xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                    
                }
                
                ForEach(filters, id: \.self){ filter in
                    if selectedFilter  == nil || selectedFilter == filter {
                        FilterCell(
                            title: filter.title,
                            isDropdown: filter.isDropDown,
                            isSelected: selectedFilter == filter
                        )
                        .background(
                            Color.netflixBlack.opacity(0.001)
                        )
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && filter == filters.first!) ? 16 : 0)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

//Binding with possibilities to do others development into the app
fileprivate struct FilterBarViewPreview: View {
    
    @State private var filter = FilterModel.mockArray
    @State private var seletedFilter: FilterModel? = nil
    
    var body: some View {
        FilterBarView(filters: filter,
                      selectedFilter: seletedFilter,
                      onFilterPressed: {
            newFilter in
            seletedFilter = newFilter
            
        },
                      onXMarkPressed: {
            seletedFilter = nil
        })
    }
}

#Preview {
    ZStack{
        Color.netflixBlack.ignoresSafeArea()
        
        FilterBarViewPreview()
    }
}
