//
//  ComicModel.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import Foundation

// MARK: - ComicModel
struct ComicModel: Codable, Identifiable{
    let month: String
    let id = UUID()
    let num: Int
    let link, year, news, safeTitle: String?
    let transcript, alt: String?
    let img: String
    let title, day: String

    enum CodingKeys: String, CodingKey {
        case month, link, year, news
        case safeTitle = "safe_title"
        case transcript, alt, img, title, day
        case num
    }
}
