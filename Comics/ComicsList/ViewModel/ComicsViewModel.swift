//
//  ComicsViewModel.swift
//  Comics
//
//  Created by Shimna Rasheed on 18/04/21.
//

import Foundation

// MARK: - ComicFetchProtocol
protocol ComicFetchProtocol {
    func fetchAllComics()
    func fetchFavouriteComics()
}

class ComicsViewModel: ObservableObject {
    // MARK: Dependency
    var apiManager: APIManager
    var dataManager: FavouriteDataManagerProtocol
    
    //Publishers
    @Published var comics: [ComicModel]?
    @Published var error: Error?
    @Published var loading = false
    
    //private properties
    private var selectedTab: String?
    private var comicsArray = [ComicModel]()
    
    //Constructor
    init(apiManager: APIManager, dataManager: FavouriteDataManagerProtocol){
        self.apiManager = apiManager
        self.dataManager = dataManager
        //Calling APi to fetch all Comics
        fetchAllComics()
    }
    
}

// MARK: - ComicFetchProtocol
extension ComicsViewModel: ComicFetchProtocol {
    
    func fetchAllComics() {
        self.fetchComics(APIString: Endpoint.allComicFetchAPI.rawValue)
    }

    func fetchFavouriteComics() {
        DispatchQueue.main.async {
            //Fetching favorite Comic stored in coredata
            self.comics = self.dataManager.fetchFavouriteComicList()
        }
    }
}

// MARK: - Private Methods
extension ComicsViewModel {
    /*
     Method to call API to fetch Comic 
     */
    private func fetchComics(APIString: String) {
        print("fetching data........")
        loading = true
        
        //Creating a queue to call all webservices asychronously
        let dispatchQueue = DispatchQueue(label: StaticTexts.queue, qos: .background)
        //Iterating up to 10 to fetch 10 Comics
        for i in 0..<10 {
            //Creating random numbers to comic id
            let randomInt = Int.random(in: i..<2000)
            //Generating API string with comic id
            let endUrlString = String(format: APIString ,randomInt)
            print(endUrlString)
            
            //Asynchronously calling 10 APIs for fetching Comics
            dispatchQueue.async {
                //calling API to fetch data from server
                self.apiManager.fetchItems(API: endUrlString) { [weak self] (result: Result<ComicModel, Error>) in
                    
                    //Handling result
                    switch result {
                    case .success(let comicModel):
                        //Success case, and taking comicModel then appending to comicArray to show in view
                        self?.comicsArray.append(comicModel)
                        
                        if self?.comicsArray.count == 10 {
                            DispatchQueue.main.async {
                                self?.error = nil
                                self?.comics = self?.comicsArray
                                //Updating loading state
                                self?.loading = false
                            }
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        //Handling error cases
                        if !(self?.comicsArray.isEmpty ?? true) {
                            DispatchQueue.main.async {
                                self?.comics = self?.comicsArray
                                self?.loading = false
                            }
                        }
                        self?.error = error
                    }
                }
            }
        }
    }
}

// MARK: - Public Methods
extension ComicsViewModel{
    /*
     Method to handle tab selections and perform repsctive actions
     */
    func handleTabSelection(selectedTab: String) {
        self.selectedTab = selectedTab
        switch selectedTab{
        case Options.AllComics.rawValue:
            //Checking for already loaded comic array
            if !self.comicsArray.isEmpty {
                DispatchQueue.main.async {
                    //Assigning already loaded comic array to update in UI
                    self.comics = self.comicsArray
                }
            } else {
                //Fetching comics from server
                self.fetchAllComics()
            }
            break
            
        case Options.Favourite.rawValue:
            self.fetchFavouriteComics()
            break
            
        default:
            break
        }
    }
}

// MARK: - DataFetchProtocol Methods
extension ComicsViewModel: DataFetchProtocol {
    func updateView() {
        //Reload data only if the selected tab is favorite
        if self.selectedTab == Options.Favourite.rawValue {
            self.fetchFavouriteComics()
        }
    }
}
