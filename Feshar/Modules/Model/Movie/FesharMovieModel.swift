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
    let vote_average: Double
    let title: String
    let overview: String
}
