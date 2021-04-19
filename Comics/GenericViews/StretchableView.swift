//
//  StretchyView.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI

struct StretchableView<Content: View>: View {
    //MARK:- Properties
    var minHeight: CGFloat
    var content: Content
    
    //MARK:- Initializer
    init(minHeight: CGFloat = 480, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.content = content()
    }
    
    //MARK:- Main Body
    var body: some View {
        
        GeometryReader { reader in
            
            //Parallax
            if reader.frame(in: .global).minY > -(minHeight) {
                content
                    // moving View Up
                    .offset(y: -reader.frame(in: .global).minY)
                    // going to add parallax effect
                    .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + minHeight : minHeight)
                    // adding blur effect
                    .blur(radius: self.getBlurRadiusForImage(reader))
            }

        }
        // default frame
        .frame(height: minHeight)
    }

}

extension StretchableView {
    //Calculating blur value based on content view scrolling frame
    private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY
        
        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height 
        
        return blur * 7 // Values will range from 0 - 7
    }
}
