//
//  ProfileView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 16/04/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(AppData.self) private var appData
    @State private var animateToCenter: Bool = false
    
    var body: some View {
        VStack{
            
            headerSection
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(100), spacing: 24), count: 2)) {
                ForEach(mockProfiles){ profile in
                    ProfileCardView(profile)
                }
                
                //Add New Profile Button
                addButtonSection
            }
            .frame(maxHeight: .infinity)
        }
        .padding(16)
        .opacity(animateToCenter ? 0 : 1)
        .overlayPreferenceValue(RectangleAnchorKey.self) { value in
            AnimationLayerProfileView(value)
        }
   }
    
    
    @ViewBuilder
    func AnimationLayerProfileView(_ anchors: [String: Anchor<CGRect>]) -> some View {
        GeometryReader{ geometry in
            if let profile = appData.watchingProfile,
               let sourceAnchor = anchors[profile.sourceAnchorID], appData.animateProfile {
                let newRect = geometry[sourceAnchor]
                let screenRect = geometry.frame(in: .global)
                
                let mainImagePosition = CGPoint(x: newRect.midX, y: newRect.minY)
                let centerImagePosition = CGPoint(x: screenRect.width / 2, y: (screenRect.height / 2) - 45)
                
                let destinationPosition = CGPoint(x: appData.tabProfileRectangle.minX, y: appData.tabProfileRectangle.midY)
                
                //Profile Image view selection with progressView loader
                ZStack{
                    Image(profile.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: newRect.width, height: newRect.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .position(destinationPosition)
                    
                    ImageLoader()
                        .frame(width: 45,height: 45)
                        .offset(y: 80)
                        .opacity(animateToCenter ? 1 : 0)
                }
                .transition(.identity)
                .task {
                    guard !animateToCenter else { return }
                    await animateUser()
                }
            }
               
        }
    }
    
    func animateUser() async {
        withAnimation(.bouncy(duration: 0.40)){
            animateToCenter = true
        }
        
        await loadContents()
    }
    
    func loadContents() async {
        try? await Task.sleep(for: .seconds(2))
    }
    
    private var headerSection: some View{
        Button("Edit"){
            
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .overlay{
            Text("Who's Watching ?")
                .foregroundStyle(.netflixWhite)
                .font(.title3.bold())
        }
        .foregroundStyle(.netflixRed)
    }
    
    private var addButtonSection: some View{
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.netflixWhite.opacity(0.8), lineWidth: 0.8)
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundStyle(.netflixWhite)
            }
            .frame(width: 100, height: 100)
            .contentShape(.rect)
        })
    }
    
    @ViewBuilder
    func ProfileCardView(_ profile: Profile) -> some View{
        VStack(spacing: 8) {
            let status = profile.id == appData.watchingProfile?.id
            GeometryReader { _ in
                Image(profile.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .opacity(animateToCenter ? 0 : 1)

            }
            .animation(status ? .none : .bouncy(duration: 0.40), value: animateToCenter)
            .frame(width: 100, height: 100)
            .anchorPreference(key: RectangleAnchorKey.self, value: .bounds, transform: { anchor in
                return [profile.sourceAnchorID: anchor]
            })
            .onTapGesture {
                appData.watchingProfile = profile
                appData.animateProfile = true
            }
            
            Text(profile.name)
                .fontWeight(.semibold)
                .lineLimit(1)
                .foregroundStyle(.netflixWhite)
        }
    }
}

#Preview {
//    ZStack {
//        Color.netflixBlack.ignoresSafeArea()
//        
//        ProfileView()
//            .environment(AppData())
//    }
    ContentView()
}
