//
//  ComicView.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicView: View {
    // MARK: - Private
    var comic: ComicModel
    var viewModel: ComicsViewModel
    
    // MARK: - Body
    var body: some View {
            VStack(spacing: 8) {
                //Creating Image view for banner
                WebImage(url: URL(string: comic.img ))
                    .resizable()
                    .scaledToFill()
                    .modifier(WebImageModifier())
                    .frame( maxHeight: UIScreen.main.bounds.height-50)
                
                //Creating title view
                Text(comic.title )
                    .modifier(TitleModifier())

            }
    }
}
