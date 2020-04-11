//
//  RegisteredUserClass.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/28/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

class RegisteredUser {
    let username: String = "AbdelrhmanEliwa"
    let password: String = "Robusta.123"
}

var userName: String?
var sessionID: String?

struct LoggedInUser {
    let username: String?
    let sessionID: String?
}
