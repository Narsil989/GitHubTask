//
//  ApiEndpoint.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation
enum ApiEndpoint {
    case searchRepos(searchText: String, sortBy: SortingKey? = nil, descending: Bool = true, pageNumber: Int = 0)
    case repoDetails(repo: GitRepository)
    case reposiroties(author: Author, pageNumber: Int = 0)
}

extension ApiEndpoint: APICall {
    var path: String {
        switch self {
        case .searchRepos:
            return "/search/repositories"
        case let .repoDetails(repo):
            return "/repos/\(repo.author.name)/\(repo.name)"
        case let .reposiroties(author, _):
            return "/users/\(author.name)/repos"
        }
    }
    var method: String {
        switch self {
        case .searchRepos,
             .repoDetails,
             .reposiroties:
            return "GET"
        }
    }
    var headers: [String: String]? {
        return baseHeader
    }
    
    var queryParameters: [URLQueryItem]? {
        var base: [URLQueryItem] = []
        switch self {
        case .searchRepos(let query, let sortingKey, let descending, let pageNumber):
            base.append(URLQueryItem(name: "q", value: query))
            base.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
            if let sortBy = sortingKey {
                base.append(sortBy.queryItem)
            }
            base.append(descending == true ? SortingOrder.desc.queryItem : SortingOrder.asc.queryItem)
        case .reposiroties(_, let pageNumber):
            base.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
        case .repoDetails:
            debugPrint("no query items needed")
        }
        return base
    }
    
    var baseHeader: [String: String] {
        return  ["Accept": "application/vnd.github.v3+json"]
    }
    
    var baseURL: String {
        return ApiConfig.baseUrl
    }
    
    func body() throws -> Data? {
        return nil
    }
}
