//
//  MoviePostersModel.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/21/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct MoviePostersModel: Codable {
    let id: Int
    let posters: [Posters]
}

struct Posters: Codable {
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "file_path"
    }
}
