//
//  LoginResponse.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/11/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let success: Bool?
    let expiresAt: String?
    let requestToken: String?
    let errorMsg: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case errorMsg = "status_message"
    }
}
