//
//  Constants.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import Foundation

/**
 enum that holds all Urls
 */
enum Endpoint: String{
    //setting base url
    static let baseUrl = "https://xkcd.com/"
    
    case allComicFetchAPI = "%d/info.0.json"
    case none
}

/**
 enum that holds all the error messages
 */
public enum Errors: String {
    case networkError
    case parsingError
    case commonError
    
    var errorType: String {
        switch self {
        case .networkError:
            return "Device is not connected to the Internet"
        case .parsingError:
            return "Parsing failed"
        case .commonError:
            return "Something went wrong, please try again"
        }
    }
}

/**
 enum that holds all the top tab options
 */
enum Options: String {
  case AllComics = "AllComics"
  case Favourite = "Favourite"
}
/**
Struct for all  static texts used in entire aplication
 */
struct StaticTexts {
    static let error = "Error"
    static let OK = "OK"
    static let queue = "queue"
}
