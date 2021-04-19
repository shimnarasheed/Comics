//
//  Font+Custom.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI

struct FontType {
    static let bold: String =  "AvenirNext-Bold"
    static let regular: String = "AvenirNext-Regular"
    static let normal: String = "Avenir Next"
    static let boldItalic: String = "AvenirNext-BoldItalic"
    static let heavy: String = "AvenirNext-Heavy"
}


extension Font {
    static func avenirNext(size: Int) -> Font {
        return Font.custom(FontType.normal, size: CGFloat(size))
    }
    
    static func avenirNextRegular(size: Int) -> Font {
        return Font.custom(FontType.regular, size: CGFloat(size))
    }
    
    static func avenirNextBold(size: Int) -> Font {
        return Font.custom(FontType.bold, size: CGFloat(size))
    }
    
    static func avenirNextBoldItalic(size: Int) -> Font {
        return Font.custom(FontType.boldItalic, size: CGFloat(size))
    }
    
    static func avenirNextHeavy(size: Int) -> Font {
        return Font.custom(FontType.heavy, size: CGFloat(size))
    }
}
