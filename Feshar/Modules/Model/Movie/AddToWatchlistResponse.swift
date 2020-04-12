//
//  AddToWatchlistResponse.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/11/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct AddToWatchlistResponse: Codable {
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
    }
}
