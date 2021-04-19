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
                WebImage(url: URL(string: comic.img))
                    .resizable()
                    .scaledToFit()
                    .modifier(WebImageModifier())
                
                //Creating title view
                Text(comic.safeTitle ?? "" )
                    .modifier(TitleModifier())
                
            }
    }
}
