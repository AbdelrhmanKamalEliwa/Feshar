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
    let voteAverage: Double
    let title: String
    let overview: String
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case voteAverage = "vote_average"
        case title = "title"
        case overview = "overview"
        case mediaType = "media_type"
    }
}

struct MovieDetailsScreen: Codable {
    let id: Int
    let title: String
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case voteAverage = "vote_average"
        case overview = "overview"
    }
}
