//
//  LogoutNetworkManager.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/12/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

class LogoutNetworkManager {
    func logout(sessionId: String, completion: @escaping(_ response: LogoutResponse?) -> ()) {
        let networkManager = NetworkManager()
        let postData = try! JSONEncoder().encode(LogoutRequest(seesionId: sessionId))
        
        let _ = networkManager.request(url: EndPointRouter.deleteSessionId, httpMethod: .delete, parameters: postData, headers: ["Content-Type":"application/json"]) { (result: APIResult<LogoutResponse>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                if let error = error {
                    print(error)
                }
            case .decodingFailure(let error):
                if let error = error {
                    print(error)
                }
            case .badRequest(let error):
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
