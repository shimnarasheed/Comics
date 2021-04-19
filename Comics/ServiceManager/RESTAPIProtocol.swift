//
//  APIProtocol.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import Foundation
import Combine

/**
 enum that holds all the https method types
 */
private enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}


protocol RESTAPIProtocol {
    typealias RequestModifier = ((URLRequest) -> URLRequest)
    
    var baseURL:String { get }
    var urlSession:URLSession { get }
}

extension RESTAPIProtocol {
    var urlSession: URLSession { URLSession.shared }
    
    func get(endpoint:String, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
        let urlStr = baseURL + endpoint
        guard let url = URL(string: urlStr) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return createPublisher(for: request, requestModifier: requestModifier)
    }
    
    func put(endpoint:String, body: Data?, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
        guard let url = URL(string: "\(baseURL)")?.appendingPathComponent(endpoint) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        request.httpBody = body
        return createPublisher(for: request, requestModifier: requestModifier)
    }
    
    func post(endpoint:String, body: Data?, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
        guard let url = URL(string: "\(baseURL)")?.appendingPathComponent(endpoint) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = body
        return createPublisher(for: request, requestModifier: requestModifier)
    }
    
    func patch(endpoint:String, body: Data?, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
        guard let url = URL(string: "\(baseURL)")?.appendingPathComponent(endpoint) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.patch.rawValue
        request.httpBody = body
        return createPublisher(for: request, requestModifier: requestModifier)
    }
    
    func delete(endpoint:String, requestModifier:@escaping RequestModifier = { $0 }) -> URLSession.ErasedDataTaskPublisher {
        guard let url = URL(string: "\(baseURL)")?.appendingPathComponent(endpoint) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        return createPublisher(for: request, requestModifier: requestModifier)
    }
    
    func createPublisher(for request:URLRequest, requestModifier:@escaping RequestModifier) -> URLSession.ErasedDataTaskPublisher {
        Just(request)
            .setFailureType(to: Error.self)
            .flatMap { [self] in
                urlSession.erasedDataTaskPublisher(for: requestModifier($0))
            }.eraseToAnyPublisher()
    }
}

struct API {
    enum URLError: Error {
        case unableToCreateURL
    }
    enum AuthorizationError:Error {
        case unauthorized
    }
    enum HTTPError:Error {
        case statusCode
    }
}
