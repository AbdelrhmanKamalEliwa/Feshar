//
//  WatchlistModel.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

class WatchlistModel {
    let movieName: String?
    let movieDetails: String?
    let movieRate: String?
    let movieImage: String?
    
    init(movieName: String, movieDetails: String, movieRate: String, movieImage: String) {
        self.movieName = movieName
        self.movieDetails = movieDetails
        self.movieRate = movieRate
        self.movieImage = movieImage
    }
}
