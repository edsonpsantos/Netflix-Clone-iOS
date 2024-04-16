//
//  CustomTabBar.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 15/04/2024.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Environment(AppData.self) private var appData
    let IconProfile: String = "Profile"
    private var imageName: String = Constants.randomImage
    private var homeViewName: String = Constants.homeViewName
    
    var body: some View {
        HStack(spacing: 0){
            ForEach(TabBar.allCases, id: \.rawValue){ tab in
                Button  {
                    appData.activeTab = tab
                } label: {
                    VStack(spacing: 2){
                        Group{
                            if tab.icon == IconProfile {
                                GeometryReader{ geometry in
                                    let rect = geometry.frame(in: .named(homeViewName))
                                    
                                    ImageLoaderView(urlString: imageName)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    
                                    Color.clear
                                        .preference(key: RectangleKey.self, value: rect)
                                        .onPreferenceChange(RectangleKey.self){
                                            appData.tabProfileRectangle = $0
                                        }
                                 }
                                    .frame(width: 35, height: 35)
                            }else {
                                Image(systemName: tab.icon)
                                    .font(.title3)
                                    .frame(width: 35, height: 35)
                            }
                        }
                        .keyframeAnimator(initialValue: 1, trigger: appData.activeTab) { content, scale in
                            content.scaleEffect(appData.activeTab == tab ? scale : 1 )
                        } keyframes: { _ in
                            CubicKeyframe(1.2, duration: 0.2)
                            CubicKeyframe(1, duration: 0.2)
                        }
                        
                        
                        Text(tab.rawValue)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.netflixWhite)
                    .animation(.snappy){ content in
                        content
                            .opacity(appData.activeTab == tab ? 1 : 0.6)
                    }
                    .contentShape(.rect)
                }
                .buttonStyle(NoAminationButtonStyle())
            }
        }
        .padding(.bottom, 10)
        .padding(.top, 4)
        .background{
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        HomeView()
            .environment(AppData())
    }
}
