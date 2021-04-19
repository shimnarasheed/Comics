//
//  ComicCarouselView.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI

// For Top Scrolling Tab Buttons....
var scroll_Tabs = [Options.AllComics.rawValue, Options.Favourite.rawValue]

struct ComicCarouselView: View {
    // MARK: -  properties
    @ObservedObject var viewModel: ComicsViewModel
    @State var show = false
    @State var selectedItem : ComicModel!
    @Namespace var animation
    @State var selectedTab = scroll_Tabs[0]
    @State private var shouldAnimate = false
    @State  var showAlert = false
    
    // MARK: - Body
    var body: some View {

        ZStack() {
            //Showing loader when calling API
            if(viewModel.loading) {
                Loader(shouldAnimate: self.$shouldAnimate)
                    .onDisappear() {
                        //Changing error state to show error alert(if any errors)
                        showAlert = (viewModel.error != nil) ? true : false
                    }

            } else {
                VStack (alignment: .leading, spacing: 17) {
                    //Creating to tab bar
                    OptionView(viewModel: viewModel, selectedTab: $selectedTab, showBar: $show, animation: animation)
                        .padding(.leading, 15)

                    //Creating ComicView with Parallax effect
                    ParallaxZoomView(viewModel.comics ?? []) { comic  in
                        ComicView(comic: comic, viewModel: viewModel)
                        
                    } selectionHandler: { item in
                        //Handling Comic selection
                    }

                    .onAppear {
                        //Changing state object to stop loader and
                        self.shouldAnimate = false
                    }
                    Spacer()
                }
                .padding(.top , 50)
                .ignoresSafeArea(.all, edges: .top)
                
            }
        }
        //Setting alert for error cases.
        .alert(isPresented:$showAlert) {
            Alert(title: Text(StaticTexts.error), message: Text(viewModel.error?.localizedDescription ?? ""), dismissButton: .default(Text(StaticTexts.OK)))
        }
       
    }
}
