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
    var dataManager: FavouriteDataManagerProtocol
    
    // MARK: Constructor
    init(comicModel: ComicModel, dataManager: FavouriteDataManagerProtocol) {
        self.dataManager = dataManager
        self.comic = comicModel
        self.isFavorite = self.findAlreadyAdded()
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
        return dataManager.isAlreadyAdded(comic: self.comic)
    }
    
    func addToFavourite() {
        self.isFavorite = true
        dataManager.addToFavourite(comic: self.comic)
    }
    
    func unFavourite() {
        self.isFavorite = false
        dataManager.unFavourite(comic: self.comic)
        //Delegate method is used to update the favourite list when unfavourite the movie.
        dataDelegate?.updateView()
    }
}






