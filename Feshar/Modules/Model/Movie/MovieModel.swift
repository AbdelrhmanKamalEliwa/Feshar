//
//  Movie.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

class MovieModel {
    let movieName: String?
    let movieDetails: String?
    let movieType: String?
    let movieRate: String?
    let movieDescription: String?
    let movieImage: String?
    
    init(movieName: String, movieDetails: String, movieType: String, movieRate: String, movieDescription: String, movieImage: String) {
        self.movieName = movieName
        self.movieDetails = movieDetails
        self.movieType = movieType
        self.movieRate = movieRate
        self.movieDescription = movieDescription
        self.movieImage = movieImage
    }
    
}
