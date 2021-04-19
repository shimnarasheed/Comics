//
//  ComicDetailViewModel.swift
//  Comics
//
//  Created by Shimna Rasheed on 19/04/21.
//

import Foundation
import SwiftUI

// MARK: ComicDetailProtocol
protocol ComicDetailProtocol {
    func addToFavourite()
    func findAlreadyAdded() -> Bool
    func unFavourite()
}

// MARK: DataFetchProtocol
@objc protocol DataFetchProtocol {
  func updateView()
}

// MARK: Class
class ComicDetailViewModel: ObservableObject {
    
    // MARK: Properties
    var comic: ComicModel
    @Published var isFavorite: Bool?
    
    // MARK: Delegation
    @objc weak var dataDelegate: DataFetchProtocol?
    
    // MARK: Constructor
    init(comicModel: ComicModel) {
        self.comic = comicModel
    }
}

// MARK: Public
extension ComicDetailViewModel {
    func favouriteOrUnfavourite() {
        if isFavorite == true {
            //do unfavourite
            self.unFavourite()
        } else {
            //do favourite
            self.addToFavourite()
        }
    }
}

// MARK: ComicDetailProtocol methods
extension ComicDetailViewModel: ComicDetailProtocol{
    
    func findAlreadyAdded() -> Bool {
        return false
    }
    
    func addToFavourite() {
    }
    
    func unFavourite() {
       
    }
}






