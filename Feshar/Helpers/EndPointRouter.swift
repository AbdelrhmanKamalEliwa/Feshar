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
        return URL(string: APIService.baseURL() + "/trending/movie/week?api_key=6c52966d9be717e486a2a0c499867009&page=1&sort_by=release_date.desc#")!
    }
    
    static func getMovieDetails(movieId: String) -> URL {
        return URL(string: APIService.baseURL() + "/movie/" + movieId + "?api_key=6c52966d9be717e486a2a0c499867009&language=en-US")!
    }
    
    static func getMoviePoster(posterPath: String) -> String {
        return MoviePosterServices.baseUrlImage() + posterPath
    }
    
    static var getMovies: URL {
//        return URL(string: APIService.newBaseUrl(body: "/movie/550?api_key="))!
        return URL(string: APIService.baseURL() + "/trending/movie/week?api_key=" + APIService.apiKey() + "&page=1&sort_by=release_date.desc#")!
    }
    
    static var createRequestToken: URL {
        return URL(string: APIService.baseURL() + "/authentication/token/new?api_key=" + APIService.apiKey())!
    }
    
    static var createLoginAuthentication: URL {
        return URL(string: APIService.baseURL() + "/authentication/token/validate_with_login?api_key=" + APIService.apiKey())!
    }
//    static var c
}
