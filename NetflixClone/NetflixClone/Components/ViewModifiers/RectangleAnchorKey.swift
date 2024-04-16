//
//  RectangleAnchorKey.swift
//  NetflixClone
//
//  Created by EDSON SANTOS on 16/04/2024.
//

import SwiftUI

struct RectangleAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) {
            $1
        }
    }
}


struct RectangleKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
