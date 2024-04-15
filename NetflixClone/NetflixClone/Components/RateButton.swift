//
//  RateButton.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI


enum RateOptions: String, CaseIterable{
    case dislike, like, love
    
    var title: String{
        switch self {
        case .dislike:
            return "Not for me"
        case .like:
            return "I like this"
        case .love:
            return "I love this"
        }
    }
    
    var iconName: String {
        switch self {
        case .dislike:
            return "hand.thumbsdown"
        case .like:
            return "hand.thumbsup"
        case .love:
            return "heart"
        }
    }
}

struct RateButton: View {
    
    @State private var showPopover : Bool = false
    var onRatingSelected:((RateOptions)-> Void)? = nil
    
    var body: some View {
        VStack(spacing: 8) {
            
            Image(systemName: "hand.thumbsup")
                .font(.title2)
            
            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
            
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.netflixBlack.opacity(0.001))
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover,
                 content: {
            ZStack{
                Color.netflixDarkGray.ignoresSafeArea()
                
                HStack(spacing: 12){
                    ForEach(RateOptions.allCases, id: \.self){ option in
                        rateButton(option: option)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .presentationCompactAdaptation(.popover)
        })
        
    }
    
    private func rateButton(option: RateOptions) -> some View{
        VStack(spacing: 8){
            Image(systemName: option.iconName)
                .font(.title2)
            
            Text(option.title)
                .font(.caption)
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(.netflixBlack.opacity(0.001))
        .onTapGesture {
            onRatingSelected?(option)
        }
    }
}


#Preview {
    ZStack{
        Color.netflixBlack.ignoresSafeArea()
        
        RateButton()
    }
}
