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
    case auth
    case accessToken(code: String)
    case user(token: String)
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
        case .auth:
            return "/login/oauth/authorize"
        case .accessToken:
            return "/login/oauth/access_token"
        case .user:
            return "/user"
        }
    }
    var method: String {
        switch self {
        case .searchRepos,
             .repoDetails,
             .reposiroties,
             .auth,
             .user:
            return "GET"
        case .accessToken:
            return "POST"
        }
    }
    var headers: [String: String]? {
        return baseHeader
    }
    
    var queryParameters: [URLQueryItem]? {
        var base: [URLQueryItem] = []
        switch self {
        case let .searchRepos(query, sortingKey, descending, pageNumber):
            base.append(URLQueryItem(name: "q", value: query))
            base.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
            if let sortBy = sortingKey {
                base.append(sortBy.queryItem)
            }
            base.append(descending == true ? SortingOrder.desc.queryItem : SortingOrder.asc.queryItem)
        case .reposiroties(_, let pageNumber):
            base.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
        case .auth:
            base.append(URLQueryItem(name: "client_id", value: ApiConfig.appCredentials().clientId))
        case .accessToken(let code):
            base.append(URLQueryItem(name: "client_id", value: ApiConfig.appCredentials().clientId))
            base.append(URLQueryItem(name: "client_secret", value: ApiConfig.appCredentials().clientSecret))
            base.append(URLQueryItem(name: "code", value: code))
        case .repoDetails, .user:
            debugPrint("no query items needed")
        }
        return base
    }
    
    var baseHeader: [String: String] {
        switch self {
        case .accessToken:
            return ["Accept": "application/json"]
        case .user(let token):
            return ["Authorization": "token \(token)","Accept": "application/vnd.github.v3+json"]
        default:
            return  ["Accept": "application/vnd.github.v3+json"]
        }
    }
    
    var baseURL: String {
        switch self {
        case .auth, .accessToken:
            return ApiConfig.baseUrl
        default:
            return ApiConfig.baseApiUrl
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
}
