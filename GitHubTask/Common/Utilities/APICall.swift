//
//  APICall.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation

protocol APICall {
    var path: String { get }
    var baseURL: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var queryParameters: [URLQueryItem]? { get }
    func body() throws -> Data?
}

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        }
    }
}

extension APICall {
    func urlRequest() throws -> URLRequest {
        guard let url = URL(string: self.baseURL + path) else {
            throw APIError.invalidURL
        }
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = queryParameters?.compactMap({ $0 })
        guard let newUrl = components?.url else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: newUrl)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
