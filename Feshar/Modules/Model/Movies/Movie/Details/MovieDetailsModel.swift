//
//  FesharMovieModel.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct MovieDetailsScreen: Codable {
    let id: Int
    let title: String
    let imdbRate: Double
    let description: String
    let poster: String
    let genres: [Genres]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imdbRate = "vote_average"
        case description = "overview"
        case poster = "poster_path"
        case genres
    }
}

struct Genres: Codable {
    let name: String
}
