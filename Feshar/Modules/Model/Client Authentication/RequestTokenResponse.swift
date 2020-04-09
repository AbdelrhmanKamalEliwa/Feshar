//
//  RequestTokenResponse.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/8/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct RequestTokenResponse: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

//struct RequestResponse {
//    var requestRespone = ""
//}

//class RequestTokenResponse {
////    func fetchData() {
////        let networkManager = NetworkManager()
////        let _ = networkManager.request(url: EndPointRouter.createRequestToken, httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<RequestToken>) in
////            switch result {
////
////            case .success(let data):
////                DispatchQueue.main.async {
////                    RequestResponse.requestRespone = data.requestToken
////                }
//////                print(data.requestToken)
////
////            case .failure(let error):
////                if let error = error {
////                    print(error)
////                }
////            case .decodingFailure(let error):
////                if let error = error {
////                    print(error)
////                }
////            case .badRequest(let error):
////                if let error = error {
////                    print(error)
////                }
////            }
////        }
////    }
//}
