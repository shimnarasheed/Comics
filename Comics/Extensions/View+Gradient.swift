//
//  View+Gradient.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI

extension View {
    public func gradientForeground() -> some View {
        self.overlay(Colors().appThemeGradient())
            .mask(self)
    }
}
