//
//  LogoutRequest.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/12/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct LogoutRequest: Codable {
    let seesionId: String
    
    enum CodingKeys: String, CodingKey {
        case seesionId = "session_id"
    }
}
