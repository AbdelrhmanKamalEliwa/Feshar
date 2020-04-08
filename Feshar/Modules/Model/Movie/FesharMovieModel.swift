//
//  FesharMovieModel.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct MovieHomeScreen: Codable {
    let results: [Results]
}

struct Results: Codable {
    let id: Int
    let imdbRate: Double
    let title: String
    let description: String
    let mediaType: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imdbRate = "vote_average"
        case title = "title"
        case description = "overview"
        case mediaType = "media_type"
        case poster = "poster_path"
    }
}

struct MovieDetailsScreen: Codable {
    let id: Int
    let title: String
    let imdbRate: Double
    let description: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imdbRate = "vote_average"
        case description = "overview"
        case poster = "poster_path"
    }
}
