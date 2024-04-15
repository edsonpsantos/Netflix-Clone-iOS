//
//  ListButtons.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

struct MyListButtons: View {
    
    var isMyList: Bool = false
    var onButtonPressed: (()->Void)? = nil
    
    var body: some View {
        VStack(spacing: 8) {
            
            ZStack{
                Image(systemName: "checkmark")
                    .opacity(isMyList ? 1 : 0)
                    .rotationEffect(Angle(degrees: isMyList ? 0 : 180))
                
                Image(systemName: "plus")
                    .opacity(isMyList ? 0 : 1)
                    .rotationEffect(Angle(degrees: isMyList ? -180 : 0))


            }                        
            .font(.title2)

            
            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
            
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.netflixBlack.opacity(0.001))
        .animation(.bouncy, value: isMyList)
        .onTapGesture {
            onButtonPressed?()
        }
    }
}

fileprivate struct MyListButtonsPreview: View{
    
    @State private var isMyList: Bool = false
    
    
    var body: some View{
        MyListButtons(isMyList: isMyList) {
            isMyList.toggle()
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        MyListButtonsPreview()
    }
}
