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
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imdbRate = "vote_average"
        case title = "title"
        case description = "overview"
        case poster = "poster_path"
    }
}





//class MovieModel {
//    let movieName: String
//    let movieDetails: String
//    let movieCategoryType: String
//    let movieRate: String
//    let movieDescription: String
//    let moviePoster: String
//    let movieImages: [String]?
//    let movieTrailers: [String]?
//    var isFavorite: Bool
//
//    init(movieName: String, movieDetails: String, movieCategoryType: String, movieRate: String, movieDescription: String, moviePoster: String, movieImages: [String]?, movieTrailers: [String]?, isFavorite: Bool) {
//        self.movieName = movieName
//        self.movieDetails = movieDetails
//        self.movieCategoryType = movieCategoryType
//        self.movieRate = movieRate
//        self.movieDescription = movieDescription
//        self.moviePoster = moviePoster
//        self.movieImages = movieImages
//        self.movieTrailers = movieTrailers
//        self.isFavorite = isFavorite
//    }
//
//}

let categoriesArray = ["MOVIES", "TV SHOWS"]

var allMovies: [MovieResults] = []
let baseImage = "http://image.tmdb.org/t/p/w300/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg"


//var movieModel: [MovieModel] = [
//    MovieModel(movieName: "Star Wars: The Last Jedi (3D)", movieDetails: "Action | Science fiction - 2h 33m", movieCategoryType: "Action", movieRate: "7.5", movieDescription: "Luke Skywalker unwillingly attempts to guide young hopeful Rey in the ways of the force", moviePoster: "Star-Wars-Poster_2", movieImages: ["Star-Wars-Poster_2", "Star-Wars-Poster_3", "Star-Wars-Poster_4"], movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "The Expendables", movieDetails: "Action | Adventure - 1h 53m", movieCategoryType: "Action", movieRate: "6.5", movieDescription: "A group of mercenaries are tasked with a mission to overthrow a Latin American dictator. But they soon discover that he is a mere puppet controlled by a ruthless ex-CIA officer.", moviePoster: "Expendables-Poster", movieImages: ["Expendables-Poster", "Expendables-Poster" ,"Expendables-Poster"], movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "John Wick: Chapter 3 – Parabellum", movieDetails: "Action | Thriller - 2h 10m", movieCategoryType: "Action", movieRate: "7.5", movieDescription: "After gunning down a member of the High Table -- the shadowy international assassin's guild -- legendary hit man John Wick finds himself stripped of the organization's protective services.", moviePoster: "John-Wick-Poster", movieImages: ["John-Wick-Poster", "John-Wick-Poster", "John-Wick-Poster"], movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "1917", movieDetails: "Drama | War - 1h 59m", movieCategoryType: "Drama", movieRate: "8.4", movieDescription: "During World War I, two British soldiers -- Lance Cpl. Schofield and Lance Cpl. Blake -- receive seemingly impossible orders. In a race against time, they must cross over into enemy territory to deliver a message that could potentially save 1,600 of their fellow comrades -- including Blake's own brother.", moviePoster: "1917-Poster", movieImages: nil, movieTrailers: nil, isFavorite: true),
//    MovieModel(movieName: "Parasite", movieDetails: "Comedy | Thriller - 2h 12m", movieCategoryType: "Comedy", movieRate: "8.6", movieDescription: "Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.", moviePoster: "Parasite-Poster", movieImages: nil, movieTrailers: nil, isFavorite: true),
//    MovieModel(movieName: "Joker", movieDetails: "Drama | Crime - 2h 2m", movieCategoryType: "Drama", movieRate: "8.5", movieDescription: "Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he's part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.", moviePoster: "Joker-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "The Irishman", movieDetails: "Drama | Crime - 3h 30m", movieCategoryType: "Drama", movieRate: "7.9", movieDescription: "In the 1950s, truck driver Frank Sheeran gets involved with Russell Bufalino and his Pennsylvania crime family. As Sheeran climbs the ranks to become a top hit man, he also goes to work for Jimmy Hoffa -- a powerful Teamster tied to organized crime.", moviePoster: "The-Irishman-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Marriage Story", movieDetails: "Drama | Romance - 2h 17m", movieCategoryType: "Drama", movieRate: "8.0", movieDescription: "A stage director and his actor wife struggle through a gruelling, coast-to-coast divorce that pushes them to their personal and creative extremes.", moviePoster: "Marriage-Story-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Taken", movieDetails: "Action | Thriller - 1h 33m", movieCategoryType: "Action", movieRate: "7.8", movieDescription: "An ex-Secret Service agent's teenage daughter is abducted by human traffickers while on a trip to Paris. With almost no information on her whereabouts, he travels to Paris to find and save her.", moviePoster: "Taken-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "The Dark Knight", movieDetails: "Action | Adventure - 2h 32m", movieCategoryType: "Action", movieRate: "9.0", movieDescription: "After Gordon, Dent and Batman begin an assault on Gotham's organised crime, the mobs hire the Joker, a psychopathic criminal mastermind who wants to bring all the heroes down to his level.", moviePoster: "The-Dark-Knight-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Eternal Sunshine Of The Spotless Mind", movieDetails: "Romance | Sci-fi - 1h 48m", movieCategoryType: "Romance", movieRate: "8.3", movieDescription: "Joel and Clementine begin a relationship post a train journey together, unaware that they had previously been in a relationship, the memories of which were clinically erased.", moviePoster: "Eternal-Sunshine-Of-The-Spotless-Mind-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "A Star Is Born", movieDetails: "Romance | Musical - 2h 14m", movieCategoryType: "Romance", movieRate: "7.7", movieDescription: "After falling in love with struggling artist Ally, Jackson, a musician, coaxes her to follow her dreams, while he battles with alcoholism and his personal demons.", moviePoster: "A-Star-Is-Born-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "The Fault in Our Stars", movieDetails: "Romance | Drama - 2h 13m", movieCategoryType: "Romance", movieRate: "7.7", movieDescription: "Two cancer-afflicted teenagers Hazel and Augustus meet at a cancer support group. The two of them embark on a journey to visit a reclusive author in Amsterdam.", moviePoster: "The-Fault-In-Our-Stars-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Love, Rosie", movieDetails: "Romance | Comedy - 1h 42m", movieCategoryType: "Romance", movieRate: "7.2", movieDescription: "Rosie and Alex have been friends since childhood and cannot imagine themselves as a couple. However, when they head in different directions, they realise that they are made for each other.", moviePoster: "Love-Rosie-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Titanic", movieDetails: "Romance | Drama - 3h 15m", movieCategoryType: "Romance", movieRate: "7.8", movieDescription: "Seventeen-year-old Rose hails from an aristocratic family and is set to be married. When she boards the Titanic, she meets Jack Dawson, an artist, and falls in love with him.", moviePoster: "Titanic-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Deadpool 2", movieDetails: "Comedy | Action - 2h 14m", movieCategoryType: "Comedy", movieRate: "7.7", movieDescription: "Deadpool protects a young mutant Russell from the authorities and gets thrown in prison. However, he escapes and forms a team of mutants to prevent a time-travelling mercenary from killing Russell.", moviePoster: "Deadpool-2-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "The Hangover", movieDetails: "Comedy - 1h 48m", movieCategoryType: "Comedy", movieRate: "7.7", movieDescription: "For a bachelor party, three best men and the groom take a road trip to Las Vegas. They wake up the next morning to realise that not only have they lost the groom but also have no recollection.", moviePoster: "The-Hangover-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Blockers", movieDetails: "Comedy | Sex comedy - 1h 42m", movieCategoryType: "Comedy", movieRate: "6.2", movieDescription: "Lisa, Mitchell and Hunter become good friends after seeing the friendship of their children. However, the parents try hard to stop their daughters from losing their virginity on prom night.", moviePoster: "Blockers-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Step Brothers", movieDetails: "Comedy - 1h 46m", movieCategoryType: "Comedy", movieRate: "6.9", movieDescription: "Brennan and Dale, two middle-aged men who still live with their parents, are forced to live together when their parents get married.", moviePoster: "Step-Brothers-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Superbad", movieDetails: "Comedy | Teen - 1h 59m", movieCategoryType: "Comedy", movieRate: "7.6", movieDescription: "Two high school boys want to enjoy their lives to the fullest before they go to different colleges. Unfortunately, their debauchery lands them in trouble.", moviePoster: "Superbad-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "1917", movieDetails: "Drama | War - 1h 59m", movieCategoryType: "New", movieRate: "8.4", movieDescription: "During World War I, two British soldiers -- Lance Cpl. Schofield and Lance Cpl. Blake -- receive seemingly impossible orders. In a race against time, they must cross over into enemy territory to deliver a message that could potentially save 1,600 of their fellow comrades -- including Blake's own brother.", moviePoster: "1917-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Parasite", movieDetails: "Comedy | Thriller - 2h 12m", movieCategoryType: "New", movieRate: "8.6", movieDescription: "Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.", moviePoster: "Parasite-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Joker", movieDetails: "Drama | Crime - 2h 2m", movieCategoryType: "New", movieRate: "8.5", movieDescription: "Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he's part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.", moviePoster: "Joker-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "The Irishman", movieDetails: "Drama | Crime - 3h 30m", movieCategoryType: "New", movieRate: "7.9", movieDescription: "In the 1950s, truck driver Frank Sheeran gets involved with Russell Bufalino and his Pennsylvania crime family. As Sheeran climbs the ranks to become a top hit man, he also goes to work for Jimmy Hoffa -- a powerful Teamster tied to organized crime.", moviePoster: "The-Irishman-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Marriage Story", movieDetails: "Drama | Romance - 2h 17m", movieCategoryType: "New", movieRate: "8.0", movieDescription: "A stage director and his actor wife struggle through a gruelling, coast-to-coast divorce that pushes them to their personal and creative extremes.", moviePoster: "Marriage-Story-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "1917", movieDetails: "Drama | War - 1h 59m", movieCategoryType: "Trending", movieRate: "8.4", movieDescription: "During World War I, two British soldiers -- Lance Cpl. Schofield and Lance Cpl. Blake -- receive seemingly impossible orders. In a race against time, they must cross over into enemy territory to deliver a message that could potentially save 1,600 of their fellow comrades -- including Blake's own brother.", moviePoster: "1917-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Joker", movieDetails: "Drama | Crime - 2h 2m", movieCategoryType: "Trending", movieRate: "8.5", movieDescription: "Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he's part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.", moviePoster: "Joker-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Star Wars: The Last Jedi (3D)", movieDetails: "Action | Science fiction - 2h 33m", movieCategoryType: "Trending", movieRate: "7.5", movieDescription: "Luke Skywalker unwillingly attempts to guide young hopeful Rey in the ways of the force", moviePoster: "Star-Wars-Poster_2", movieImages: ["Star-Wars-Poster_2", "Star-Wars-Poster_3", "Star-Wars-Poster_4"], movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "The Fault in Our Stars", movieDetails: "Romance | Drama - 2h 13m", movieCategoryType: "Trending", movieRate: "7.7", movieDescription: "Two cancer-afflicted teenagers Hazel and Augustus meet at a cancer support group. The two of them embark on a journey to visit a reclusive author in Amsterdam.", moviePoster: "The-Fault-In-Our-Stars-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//    MovieModel(movieName: "Titanic", movieDetails: "Romance | Drama - 3h 15m", movieCategoryType: "Trending", movieRate: "7.8", movieDescription: "Seventeen-year-old Rose hails from an aristocratic family and is set to be married. When she boards the Titanic, she meets Jack Dawson, an artist, and falls in love with him.", moviePoster: "Titanic-Poster", movieImages: nil, movieTrailers: nil, isFavorite: false),
//]
