//
//  SessionResponse.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/9/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    let success: Bool
    let sessionID: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}
