//
//  TrendingMoviesModel.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/10/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct TrendingMovieModel: Codable {
    let results: [TrendingMovieResults]
}

struct TrendingMovieResults: Codable {
    let id: Int
    let imdbRate: Double
    let name: String
    let originalName: String
    let description: String
    let category: [Int]
    let mediaType: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imdbRate = "vote_average"
        case name
        case originalName = "original_name"
        case description = "overview"
        case category = "genre_ids"
        case mediaType = "media_type"
        case poster = "poster_path"
    }
}
