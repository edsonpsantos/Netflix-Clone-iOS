//
//  ContentView.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 14/04/2024.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @Environment(\.router) var router
    var body: some View {
        HomeView()
    }
}

#Preview {
    ContentView()
}

