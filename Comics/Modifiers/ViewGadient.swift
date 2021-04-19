//
//  ViewGadient.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//
import SwiftUI

class Colors {
    
    //MARK:- Property
    private let backgroundThemecolors = Gradient(colors: [Color.init("ThemeGreen"),
                                                          Color.init("ThemeBlue"),
    ])
    
    
    //Method to generate a gradient for entire app theme
    func appThemeGradient() -> LinearGradient {
        let gradient = LinearGradient(gradient: backgroundThemecolors, startPoint: .leading, endPoint: .trailing)
        return gradient
    }
    
}
