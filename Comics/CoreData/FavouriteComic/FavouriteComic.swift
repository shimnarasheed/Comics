//
//  FavouriteComic.swift
//  Comics
//
//  Created by Shimna Rasheed on 19/04/21.
//

import Foundation
import CoreData

@objc(FavouriteComic)
final class FavouriteComic: NSManagedObject {
    @NSManaged var id: Int32
    @NSManaged var safeTitle: String
    @NSManaged var alt: String
    @NSManaged var img: String
    @NSManaged var year: String
}

extension FavouriteComic {
    func convertToComicModel() -> ComicModel {
        ComicModel(month: nil, id: Int(id), link: nil, year: year, news: nil, safeTitle: safeTitle, transcript:nil, alt: alt, img: img, title: nil, day: nil)
    }
}
