//
//  TVShowModel.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/10/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct TVShowModel: Codable {
    let results: [TVShowResults]
}

struct TVShowResults: Codable {
    let id: Int
    let name: String?
    let originalName: String?
    let imdbRate: Double?
    let description: String?
    let poster: String?
    let category: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case imdbRate = "vote_average"
        case description = "overview"
        case poster = "poster_path"
        case category = "genre_ids"
    }
}
