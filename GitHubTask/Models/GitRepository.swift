//
//  GitRepository.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation


struct GitRepository: Codable, Equatable {
    let name: String
    let fullName: String
    let serverId: Int
    let watchersCount: Int
    let forkCount: Int
    let issueCount: Int
    let starsCount: Int
    let language: String?
    let author: Author
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case serverId = "id"
        case watchersCount = "watchers_count"
        case forkCount = "forks_count"
        case issueCount = "open_issues"
        case starsCount = "stargazers_count"
        case language
        case author = "owner"
    }
}

func == (lhs: GitRepository, rhs: GitRepository) -> Bool {
    return lhs.name == rhs.name && lhs.serverId == rhs.serverId
}

extension GitRepository: Identifiable {
    var id: Int {
        return serverId
    }
}

