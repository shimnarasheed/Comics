//
//  APIManager.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import UIKit
import Combine


// MARK: - APIManagerProtocol
protocol APIManagerService:  RESTAPIProtocol{
    func fetchItems<T: Decodable>(API: String, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: - APIManager
@objc class APIManager: NSObject, APIManagerService {
    
    var baseURL: String {
        Endpoint.baseUrl
    }
    
    // MARK: -  Listener
    private var subscribers = Set<AnyCancellable>()
    
    //Method for fetching details from server
    func fetchItems<T: Decodable>(API: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        //Checking for network availability
        if  NetworkMonitor.shared.isReachable == true {
            
            //API call using DataTaskPublisher
            self.get(endpoint: API)
                //mapping data
                .tryMap { output in
                    //Checking for response format and its status code
                    if let response = output.response as? HTTPURLResponse, response.statusCode != 200 {
                        //Showing common error
                        completion(.failure(CustomError(message: (Errors.commonError).errorType)))
                    }
                    return output.data
                }
                //decoding data to proper model
                .decodeFromJson(T.self)
                //recieving 
                .sink(receiveCompletion: { (resultCompletion) in
                    switch resultCompletion {
                    case .failure(let error):
                        //Checking for parsing failure case
                        if let decodingError = error as? DecodingError {
                            //Printing details about parsed error
                            print((Errors.parsingError).errorType)
                            print(decodingError.localizedDescription)
                            
                            //Showing common error
                            completion(.failure(CustomError(message: (Errors.commonError).errorType)))
                        } else {
                            //Showing other error
                            completion(.failure(error))
                        }
                        
                    case .finished: break
                    }
                }, receiveValue: { (result) in
                    //Success case and returning parsed result
                    completion(.success(result))
                })
                .store(in: &subscribers)
            
        } else {
            //Showing networkError
            completion(.failure(CustomError(message: (Errors.networkError).errorType)))
        }
    }
}
