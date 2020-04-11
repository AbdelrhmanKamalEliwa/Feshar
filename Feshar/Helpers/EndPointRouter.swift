//
//  EndPointRouter.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct EndPointRouter {
    static var getMovies: URL {
        return URL(string: APIService.baseURL() + "/discover/movie?api_key=" + APIService.apiKey() + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")!
    }
    
    static func searchOnMovies(movieName: String) -> URL {
        return URL(string: APIService.baseURL() + "/search/movie?api_key=" + APIService.apiKey() + "&language=en-US&query=" + movieName + "%20exp&page=1&include_adult=false")!
    }
    
    static func getMovieDetails(movieId: String) -> URL {
        return URL(string: APIService.baseURL() + "/movie/" + movieId + "?api_key=" + APIService.apiKey() + "&language=en-US")!
    }
    
    static func getMoviePoster(posterPath: String) -> String {
        return MoviePosterServices.baseUrlImage() + posterPath
    }
    
    static var getTVShows: URL {
        return URL(string: APIService.baseURL() + "/discover/tv?api_key=" + APIService.apiKey() + "&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false")!
    }
    
//    static var getMovies: URL {
////        return URL(string: APIService.newBaseUrl(body: "/movie/550?api_key="))!
//        return URL(string: APIService.baseURL() + "/trending/movie/week?api_key=" + APIService.apiKey() + "&page=1&sort_by=release_date.desc#")!
//    }
    
    static var createRequestToken: URL {
        return URL(string: APIService.baseURL() + "/authentication/token/new?api_key=" + APIService.apiKey())!
    }
    
    static var createLoginAuthentication: URL {
        return URL(string: APIService.baseURL() + "/authentication/token/validate_with_login?api_key=" + APIService.apiKey())!
    }
    
    static var createSessionId: URL {
        return URL(string: APIService.baseURL() + "/authentication/session/new?api_key=" + APIService.apiKey())!
    }
//    static var c
}
