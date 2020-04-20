//
//  AddToWatchlistRequest.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/11/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct AddToWatchlistRequestModel: Codable {
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case watchlist
    }
}
