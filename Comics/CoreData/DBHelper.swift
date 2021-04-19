//
//  DBHelper.swift
//  Comics
//
//  Created by Shimna Rasheed on 19/04/21.
//

import Foundation
public protocol DBHelperProtocol {
    associatedtype ObjectType
    associatedtype PredicateType
    
    // MARK: -  DBHelper Protocol Methods
    func create(_ object: ObjectType)
    func fetchFirst(_ objectType: ObjectType.Type, predicate: PredicateType?) -> Result<ObjectType?, Error>
    func fetch(_ objectType: ObjectType.Type, predicate: PredicateType?, limit: Int?) -> Result<[ObjectType], Error>
    func update(_ object: ObjectType)
    func delete(_ object: ObjectType)
}


