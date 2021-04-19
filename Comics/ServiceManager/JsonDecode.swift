//
//  JsonDecode.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import Foundation
import Combine

extension Publisher {
    public func decodeFromJson<Item>(_ type: Item.Type) -> Publishers.Decode<Self, Item, JSONDecoder> where Item : Decodable, Self.Output == JSONDecoder.Input {
        return decode(type: type, decoder: JSONDecoder())
    }
}
