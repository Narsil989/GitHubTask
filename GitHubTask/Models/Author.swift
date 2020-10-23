//
//  Author.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation

struct Author: Codable, Identifiable, Equatable {
    let id: Int
    let avatar: String
    let name: String
    let userUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatar = "avatar_url"
        case name = "login"
        case userUrl = "html_url"
    }
}

func == (lhs: Author, rhs: Author) -> Bool {
    return lhs.name == rhs.name && lhs.id == rhs.id
}
