//
//  WatchlistNetworkManager.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/11/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

var actualWatchlistMoviesArray = [WatchlistMovieResults]()

class WatchlistNetworkManager {
    
    func fetchWatchlistMoviesData(comletion: @escaping(_ data: WatchlistMovieModel?) -> ()) {
        let networkManager = NetworkManager()
        if let sessionID = sessionID {
            let _ = networkManager.request(url: EndPointRouter.getWatchlistMovies(sessionId: sessionID), httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<WatchlistMovieModel>) in
                switch result {
                case .success(let data):
                    actualWatchlistMoviesArray = data.results
                    comletion(data)
                case .failure(let error):
                    if let error = error {
                        print(error)
                    }
                case .decodingFailure(let error):
                    if let error = error {
                        print(error)
                    }
                case .badRequest(let error):
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
    }
    
    
    func fetchAddToWatchlistMovies(mediaId: Int, completion: @escaping(_ addToWatchlistResponse: AddToWatchlistResponse?) -> ()) {
    let networkManager = NetworkManager()
    let postData = try! JSONEncoder().encode(AddToWatchlistRequestModel(mediaType: "movie", mediaId: mediaId, watchlist: true))
    
    if let safeSessionId = sessionID {
        let _ = networkManager.request(url: EndPointRouter.addToWatchlistMovies(sessionId: safeSessionId), httpMethod: .post, parameters: postData, headers: ["Content-Type":"application/json"]) { (result: APIResult<AddToWatchlistResponse>) in
                switch result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    if let error = error {
                        print(error)
                    }
                case .decodingFailure(let error):
                    if let error = error {
                        print(error)
                    }
                case .badRequest(let error):
                    if let error = error {
                        print(error)
                    }
                    
                }
            }
        }
    }
    
    
    func fetchDeleteFromWatchlistMovies(mediaId: Int, completion: @escaping(_ addToWatchlistResponse: AddToWatchlistResponse?) -> ()) {
    let networkManager = NetworkManager()
    let postData = try! JSONEncoder().encode(AddToWatchlistRequestModel(mediaType: "movie", mediaId: mediaId, watchlist: false))
    
    if let safeSessionId = sessionID {
        let _ = networkManager.request(url: EndPointRouter.addToWatchlistMovies(sessionId: safeSessionId), httpMethod: .post, parameters: postData, headers: ["Content-Type":"application/json"]) { (result: APIResult<AddToWatchlistResponse>) in
                switch result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    if let error = error {
                        print(error)
                    }
                case .decodingFailure(let error):
                    if let error = error {
                        print(error)
                    }
                case .badRequest(let error):
                    if let error = error {
                        print(error)
                    }
                    
                }
            }
        }
    }
    
}
