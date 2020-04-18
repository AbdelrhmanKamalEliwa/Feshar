//
//  Categories.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/17/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

class Categories {
    let movieCategoriesArray = ["All Movies", "Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "History", "Horror", "Music", "Mystery", "Romance", "Sci-Fi", "TV Movie", "Thriller", "War", "Western"]
    
    func setupFiltrationButtonsForCollectionView(allMovies: [MovieResults], cell: MovieTypesCollectionViewCell) -> [MovieResults] {
        var safeMovieModel: [MovieResults] = []
                for movie in allMovies {
                    if movie.category.contains(28) && cell.movieTypeTitleLabel.text!.lowercased() == "action" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(12) && cell.movieTypeTitleLabel.text!.lowercased() == "adventure" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(16) && cell.movieTypeTitleLabel.text!.lowercased() == "animation" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(35) && cell.movieTypeTitleLabel.text!.lowercased() == "comedy" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(80) && cell.movieTypeTitleLabel.text!.lowercased() == "crime" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(99) && cell.movieTypeTitleLabel.text!.lowercased() == "documentary" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(18) && cell.movieTypeTitleLabel.text!.lowercased() == "drama" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(10751) && cell.movieTypeTitleLabel.text!.lowercased() == "family" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(14) && cell.movieTypeTitleLabel.text!.lowercased() == "fantasy" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(36) && cell.movieTypeTitleLabel.text!.lowercased() == "history" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(27) && cell.movieTypeTitleLabel.text!.lowercased() == "horror" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(10402) && cell.movieTypeTitleLabel.text!.lowercased() == "music" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(9648) && cell.movieTypeTitleLabel.text!.lowercased() == "mystery" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(10749) && cell.movieTypeTitleLabel.text!.lowercased() == "romance" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(878) && cell.movieTypeTitleLabel.text!.lowercased() == "sci-fi" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(10770) && cell.movieTypeTitleLabel.text!.lowercased() == "tv movie" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(53) && cell.movieTypeTitleLabel.text!.lowercased() == "thriller" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(10752) && cell.movieTypeTitleLabel.text!.lowercased() == "war" {
                        safeMovieModel.append(movie)
                    } else if movie.category.contains(37) && cell.movieTypeTitleLabel.text!.lowercased() == "western" {
                        safeMovieModel.append(movie)
                    } else if cell.movieTypeTitleLabel.text!.lowercased() == "all movies" {
                        safeMovieModel = allMovies
                    }
                }
        return safeMovieModel
    }
}
