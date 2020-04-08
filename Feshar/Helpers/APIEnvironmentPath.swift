//
//  APIEnvironmentPath.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct APIService {
    static func baseURL() -> String {
        return APIEnvironmentPath.development.scheme() + APIEnvironmentPath.development.host()
    }
}

struct MoviePosterServices {
    static func baseUrlImage() -> String {
        return MoviePosterEnvironmentPath.development.scheme() + MoviePosterEnvironmentPath.development.host()
    }
}


enum APIEnvironmentPath {
    
    case development
    case testing
    case production
    
    func scheme() -> String {
        switch self {
        case .development:
            return "http://"
        case .testing:
            return ""
        case .production:
            return ""
        }
    }
    
    func host() -> String {
        switch self {
            case .development:
                return "api.themoviedb.org"
            case .testing:
                return ""
            case .production:
                return ""
        }
    }
}


enum MoviePosterEnvironmentPath {
    
    case development
    case testing
    case production
    
    func scheme() -> String {
        switch self {
        case .development:
            return "http://"
        case .testing:
            return ""
        case .production:
            return ""
        }
    }
    
    func host() -> String {
        switch self {
            case .development:
                return "image.tmdb.org/t/p/w300"
            case .testing:
                return ""
            case .production:
                return ""
        }
    }
}
