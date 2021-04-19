//
//  NetworkMonitor.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import UIKit
import Network

//To monitor internet connectivity
@objc class NetworkMonitor: NSObject {
    
    //MARK:- Singleton
    @objc static let shared = NetworkMonitor()

    //MARK:- Properties
    private let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true
    private let networkMonitor = "NetworkMonitor"
}


//MARK:- Public Accessors
extension NetworkMonitor {
    
    /*
     Method to monitor internet connection with the device
     */
    @objc func startMonitoring(completion:@escaping(Bool)->()) {
        monitor.pathUpdateHandler = { [weak self] path in
            //Here getting internet status
            //Having one known issue while checking in simulator, when reconnecting to network, NWPathMonitor is giving status as "Unsatified" , but its working fine in real devices .
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            completion(self?.isReachable ?? false)
        }
        monitor.start(queue: DispatchQueue(label: networkMonitor))
    }

    /*
     Method to stop monitoring internet status.
     */
    @objc func stopMonitoring() {
        monitor.cancel()
    }
}

