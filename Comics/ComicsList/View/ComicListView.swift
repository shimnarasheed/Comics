//
//  ContentView.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI

struct ComicListView: View {
    //Property to observe ComicsViewModel published objects
    @ObservedObject var viewModel: ComicsViewModel
    
    // MARK: - Body
    var body: some View {
        ZStack(){
            //Creating Carousel Carousel View
            ComicCarouselView(viewModel: viewModel)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}


