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
        var url =  APIService.baseURL() + "/search/movie?api_key=" + APIService.apiKey() + "&language=en-US&query="
        url = url + movieName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&page=1&include_adult=false"
        return URL(string: url)!
    }
    
    static func getMovieDetails(movieId: String) -> URL {
        return URL(string: APIService.baseURL() + "/movie/" + movieId + "?api_key=" + APIService.apiKey() + "&language=en-US")!
    }
    
    static func getWatchlistMovies(sessionId: String) -> URL {
        return URL(string: APIService.baseURL() + "/account/%7Baccount_id%7D/watchlist/movies?api_key=" + APIService.apiKey() + "&language=en-US&session_id=" + sessionId)!
    }
    
    static func addToWatchlistMovies(sessionId: String) -> URL {
        return URL(string: APIService.baseURL() + "/account/%7Baccount_id%7D/watchlist?api_key=" + APIService.apiKey() + "&session_id=" + sessionId)!
    }
    
    static func getMoviePoster(posterPath: String) -> String {
        return MoviePosterServices.baseUrlImage() + posterPath
    }
    
    static var getTVShows: URL {
        return URL(string: APIService.baseURL() + "/discover/tv?api_key=" + APIService.apiKey() + "&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false")!
    }
    
    static var getCategories: URL {
        return URL(string: APIService.baseURL() + "/genre/movie/list?api_key=" + APIService.apiKey())!
    }
    
    static var createRequestToken: URL {
        return URL(string: APIService.baseURL() + "/authentication/token/new?api_key=" + APIService.apiKey())!
    }
    
    static var createLoginAuthentication: URL {
        return URL(string: APIService.baseURL() + "/authentication/token/validate_with_login?api_key=" + APIService.apiKey())!
    }
    
    static var createSessionId: URL {
        return URL(string: APIService.baseURL() + "/authentication/session/new?api_key=" + APIService.apiKey())!
    }
    
    static var deleteSessionId: URL {
        return URL(string: APIService.baseURL() + "/authentication/session?api_key=" + APIService.apiKey())!
    }
    
}
