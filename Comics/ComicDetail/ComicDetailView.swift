//
//  ComicDetailView.swift
//  Comics
//
//  Created by Shimna Rasheed on 19/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicDetailView: View {
    //Observable viewModel object to listen if any change is happening on published properties on view model.
    @ObservedObject var viewModel: ComicDetailViewModel
    
    // MARK: Properties
    @Binding var comic: ComicModel!
    @Binding var show: Bool
    
    // MARK: body
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            ScrollView(.vertical, showsIndicators: false, content: {
                //Creating stretchable top view with blur effect
                StretchableView {
                    WebImage(url: URL(string: comic.img))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .background(Color.black)
                
                VStack(alignment: .leading,spacing: 5){
                    
                    HStack (spacing: 20){
                        //Comic Title
                        Text(comic.safeTitle ?? "")
                            .modifier(HeadingModifier())
                            .frame(width: UIScreen.main.bounds.width-100, alignment: .leading)
                        
                        //Favourite button
                        Button(action: {
                            //Favoutite or unfavourite action
                            viewModel.favouriteOrUnfavourite()
                        }) {
                            Image(systemName: (viewModel.isFavorite == true) ? ImageName.heartFill : ImageName.heart)
                                .favImageModifier(isfavorite: viewModel.isFavorite ?? false)
                        }
                    }
                    
                    //Release date view
                    Text(StaticTexts.releaseYear + " : " + (comic.year ?? ""))
                        .modifier(SubTitleModifier())
                        .padding(.top, 10)
                    
                    //Detail
                    Text(StaticTexts.details)
                        .modifier(SubTitleModifier())
                    
                    Text(comic.alt ?? "")
                        .modifier(NormalTextModifier())
                    
                    Spacer(minLength: 20)
                    
                }
                .padding(.top, 25)
                .padding(.bottom, 10)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
            })
            .background(Color.black.edgesIgnoringSafeArea(.all))
            
            //Close Button
            Button(action: {
                withAnimation(.easeOut){
                    //Changing show state to hide detail view with animation
                    show.toggle()
                }
            }) {
                
                Image(systemName: ImageName.close)
                    .modifier(closeViewModifier())
            }
            .padding(.all, 30)
        }
    }
}



