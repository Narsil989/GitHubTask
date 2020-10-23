//
//  ApiConfig.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation

final class ApiConfig {
    
    static var baseUrl: String {
        return "https://api.github.com"
    }
    
    static var defaultPageSize: Int {
        return 30
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm"
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
}

