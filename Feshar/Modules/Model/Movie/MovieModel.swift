//
//  Movie.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    let results: [MovieResults]
}

struct MovieResults: Codable {
    let id: Int
    let imdbRate: Double
    let title: String
    let description: String
    let category: [Int]
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imdbRate = "vote_average"
        case title = "title"
        case description = "overview"
        case category = "genre_ids"
        case poster = "poster_path"
    }
}

let categoriesOfFeaturedScreen = ["MOVIES", "TV SHOWS"]

var allMovies: [MovieResults] = []
