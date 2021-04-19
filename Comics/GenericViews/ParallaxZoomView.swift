//
//  ParallaxZoomView.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI

struct ParallaxZoomView<Item: Identifiable, ItemView: View>: View {
    
    //MARK:- Properties
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    private var selectionHandler: (Item) -> Void
    
    //MARK:- Constructor
    init(_ items: [Item], viewForItem: @escaping (Item)-> ItemView, selectionHandler: @escaping (Item) -> Void) {
        self.items = items
        self.viewForItem = viewForItem
        self.selectionHandler = selectionHandler
    }
    
    //MARK:- Main Body
    var body: some View {
        self.itemsOfBodyView()
    }
   
}

//MARK:- Private Methods
extension ParallaxZoomView {
    
    private func itemsOfBodyView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(items) { item in
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                       
                        self.body(for: item)
                            .scaleEffect(.init(width: scale, height: scale))
                            .animation(.spring(), value: 1)
                            .padding(.vertical)
                    }
                    .frame(width: 150, height: 400)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 37)
                }
                Spacer()
                    .frame(width: 16)
            }
        }
    }

    private func body(for item:Item) -> some View {
        self.viewForItem(item)
            .onTapGesture {
                selectionHandler(item)
            }
    }
    
    /*
     Method to calculate scale value based on geometry value
     */
    private func getScale(proxy: GeometryProxy) -> CGFloat {

        let midPoint: CGFloat = 150
        
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 150
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        return scale
    }
}

