//
//  AccessToken.swift
//  GitHubTask
//
//  Created by Dejan on 24/10/2020.
//

import Foundation

struct AccessToken: Codable {
    let accessToken: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
