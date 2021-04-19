//
//  OptionView.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI

struct OptionView: View {
    // MARK: -  properties
    var viewModel: ComicsViewModel
    @Binding var selectedTab: String
    @Binding var showBar: Bool
    var animation: Namespace.ID
    
    // MARK: - Body
    var body: some View {
        //Top tab view
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: 15){
                ForEach(scroll_Tabs,id: \.self){tab in
                    // Tab Button...
                    TabButton(title: tab, selectedTab: $selectedTab, animation: animation, selectionHandler: { selectedItem in
                        viewModel.handleTabSelection(selectedTab:selectedItem)
                    })
                }
            }
            
        })
    }
}
