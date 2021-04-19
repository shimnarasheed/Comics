//
//  Error+Description.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import Foundation
public struct CustomError: Error {
    let message: String
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
            return NSLocalizedString(message, comment: "")
    }
}
