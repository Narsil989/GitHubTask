//
//  URLExt.swift
//  GitHubTask
//
//  Created by Dejan on 20/10/2020.
//

import Foundation

extension URL {
    func googleURL() -> URL? {
        var urlString = self.absoluteString
        if urlString.contains("https://") {
                urlString = urlString.replacingOccurrences(of: "https://", with: "googlechrome://")
            } else if urlString.contains("http://") {
                urlString = urlString.replacingOccurrences(of: "http://", with: "googlechrome://")
            } else {
                urlString = "googlechrome://\(urlString)"
            }
        return URL(string: urlString)
    }
}
