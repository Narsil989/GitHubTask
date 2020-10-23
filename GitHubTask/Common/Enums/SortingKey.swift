//
//  SortingKey.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation

enum SortingKey: String, CaseIterable {
    case stars
    case forks
    case updated
    
    var queryItem: URLQueryItem {
        return URLQueryItem(name: "sort", value: rawValue)
    }
}
