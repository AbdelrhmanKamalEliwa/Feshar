//
//  EndPointRouter.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct EndPointRouter {
    static var getHomeScreen: URL {
        return URL(string: APIService.baseURL() + "/3/trending/movie/week?api_key=6c52966d9be717e486a2a0c499867009&page=1&sort_by=release_date.desc#")!
    }
    
    static func getMovieDetails(movieId: String) -> URL {
        return URL(string: APIService.baseURL() + "/3/movie/" + movieId + "?api_key=6c52966d9be717e486a2a0c499867009&language=en-US")!
    }
}
