//
//  TabButton.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI
fileprivate let tabIdentifier = "Tab"

struct TabButton: View {
    // MARK: -  properties
    var title : String
    @Binding var selectedTab : String
    var animation : Namespace.ID
    var selectionHandler: (String) -> Void
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            Text(title)
                .font(.avenirNextBold(size: 20))
            
            // adding animation...
            if selectedTab == title{
                Capsule(style: .continuous)
                    .frame(width: 40, height: 4)
                    .matchedGeometryEffect(id: tabIdentifier, in: animation)
            }
        })
        // default width...
        .frame(width: 100)
        .onTapGesture {
            withAnimation(.spring()){
                selectedTab = title
                selectionHandler(selectedTab)
            }
            
        }
        
    }
}
