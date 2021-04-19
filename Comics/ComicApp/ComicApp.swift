//
//  ComicApp.swift
//  Comics
//
//  Created by Shimna Rasheed on 19/04/21.
//

import SwiftUI
import CoreData

@main
struct ComicApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            
            //Creating managedObjectContext
            let context = CoreDataHelper.shared.persistentContainer.viewContext
            
            //Creating and injecting dependencies to view model and view classes.
            let dataManager: FavouriteDataManagerProtocol = FavouriteDataManager.shared
            ComicListView(viewModel: ComicsViewModel(apiManager: APIManager(), dataManager: dataManager))
                .environment(\.managedObjectContext, context)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NetworkMonitor.shared.startMonitoring(){
            isConnected in
            if isConnected == true {
                print("Connected to network")
            }
        }
        return true
    }
}
