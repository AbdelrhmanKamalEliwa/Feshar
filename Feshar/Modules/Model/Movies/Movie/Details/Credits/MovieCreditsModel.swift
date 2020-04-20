//
//  MovieCreditsModel.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/20/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct MovieCredits: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable {
    let castId: Int
    let character: String
    let creditId: String
    let id: Int
    let name: String
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case id
        case name
        case profileImage = "profile_path"
    }
}
