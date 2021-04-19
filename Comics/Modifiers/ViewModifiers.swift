//
//  ViewModifiers.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI


//Modifier used for title
struct TitleModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.avenirNextBold(size: 17))
            .foregroundColor(.black)
    }
}

//Modifier used for subtitle
struct SubTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.avenirNextBold(size: 15))
            .foregroundColor(.black)
        
    }
}

//Modifier used for subtitle
struct NormalTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.leading)
            .font(.avenirNext(size: 15))
            .foregroundColor(.gray)
        
    }
}

//Modifier used for heading
struct HeadingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.avenirNextBold(size: 25))
            .foregroundColor(.black)
    }
}

//Modifier used for Image
struct WebImageModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 180)
            .clipped()
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(white: 0.4))
            )
            .shadow(radius: 3)
    }
}

//Modifier used for close button
struct closeViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.black.opacity(0.7))
            .padding()
            .background(Color.white.opacity(0.8))
            .clipShape(Circle())
    }
    
}

//Modifier used favorite image
extension Image {
    func favImageModifier(isfavorite: Bool) -> some View {
        self
            .font(.title2)
            .foregroundColor((isfavorite == true) ? .white : .red)
            .padding(10)
            .background ((isfavorite == true) ? Color.red : Color.yellow)
            .clipShape(Circle())
   }
}
