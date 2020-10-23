//
//  SortingOrder.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation

enum SortingOrder: String {
    case asc
    case desc
    
    var queryItem: URLQueryItem {
        return URLQueryItem(name: "order", value: rawValue)
    }
}
