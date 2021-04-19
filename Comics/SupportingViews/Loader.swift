//
//  Loader.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI

struct Loader: View {
    @Binding var shouldAnimate: Bool
    var body: some View {
        HStack {
            ForEach(0..<3) { index  in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 15, height: 15)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(Double(index)*0.3))
            }
        }
           .onAppear {
               self.shouldAnimate = true
           }
       }
   
}

