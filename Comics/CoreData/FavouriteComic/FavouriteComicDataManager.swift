//
//  FavouriteComicDataManager.swift
//  Comics
//
//  Created by Shimna Rasheed on 19/04/21.
//

import Foundation
import CoreData

protocol FavouriteDataManagerProtocol {
    func fetchFavouriteComicList() -> [ComicModel]
    func isAlreadyAdded(comic: ComicModel) -> Bool
    func addToFavourite(comic: ComicModel)
    func unFavourite(comic: ComicModel)
}

class FavouriteDataManager {
    static let shared: FavouriteDataManagerProtocol = FavouriteDataManager()
    var dbHelper: CoreDataHelper = CoreDataHelper.shared
    
    private init() { }
}

// MARK: - DataManagerProtocol
extension FavouriteDataManager: FavouriteDataManagerProtocol {
    
    //For fetching already saved Comics in DB
    func fetchFavouriteComicList() -> [ComicModel] {
        let result: Result<[FavouriteComic], Error> = dbHelper.fetch(FavouriteComic.self)
        switch result {
        case .success(let favouriteComics):
            return favouriteComics.map { $0.convertToComicModel() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    //To add comic in DB
    func addToFavourite(comic: ComicModel) {
        let entity = FavouriteComic.entity()
        let newFavourite = FavouriteComic(entity: entity, insertInto: dbHelper.context)
        newFavourite.id = Int32(comic.id)
        newFavourite.safeTitle = comic.safeTitle ?? ""
        newFavourite.year = comic.year ?? ""
        newFavourite.alt = comic.alt ?? ""
        newFavourite.img = comic.img
        dbHelper.create(newFavourite)
    }
    
    //To remove comic from DB
    func unFavourite(comic: ComicModel) {
        let predicate = NSPredicate(format: "id == %d",comic.id)
        let result: Result<FavouriteComic?, Error> = dbHelper.fetchFirst(FavouriteComic.self, predicate: predicate)
        switch result {
        case .success(let favMovie):
            if favMovie != nil {
                dbHelper.delete(favMovie!)
            }
 
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    //Checking the existance of Comic in DB
    func isAlreadyAdded(comic: ComicModel) -> Bool {
        let predicate = NSPredicate(format: "id == %d",comic.id)
        let result: Result<FavouriteComic?, Error> = dbHelper.fetchFirst(FavouriteComic.self, predicate: predicate)
        switch result {
        case .success(let favMovie):
            guard favMovie != nil else{
                return false
            }
            return true
            
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
}

