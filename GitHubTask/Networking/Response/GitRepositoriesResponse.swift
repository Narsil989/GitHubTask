//
//  GitRepositoriesResponse.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation

struct GitRepositoriesResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GitRepository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
