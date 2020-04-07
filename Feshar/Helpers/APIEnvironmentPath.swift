//
//  APIEnvironmentPath.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct APIService {
    static func baseURL() -> String
    {
        return APIEnvironmentPath.development.scheme() + APIEnvironmentPath.development.host()
    }
}

enum APIEnvironmentPath {
    
    case development
    case testing
    case production
    
    func scheme() -> String
    {
        switch self
        {
        case .development:
            return "http://"
        case .testing:
            return ""
        case .production:
            return ""
        }
    }
    
    func host() -> String
    {
        switch self
        {
            case .development:
                return "api.themoviedb.org"
            case .testing:
                return ""
            case .production:
                return ""
        }
    }
}
