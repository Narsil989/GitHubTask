//
//  GitRepositoryDetails.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation

struct GitRepositoryDetails: Codable, Equatable, Identifiable {
    let id: Int
    let fullName: String
    let author: Author
    let repoDescription: String?
    let htmlUrl: String
    let language: String?
    let createdAt: String
    let updatedAt: String
    
    var googleChromeURL: URL? {
        URL(string: htmlUrl)?.googleURL()
    }
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case id
        case author = "owner"
        case repoDescription = "description"
        case htmlUrl = "html_url"
        case language
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func createdAtFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: createdAt) {
            dateFormatter.dateFormat = "MMM d, h:mm"
           return "Created at: " + dateFormatter.string(from: date)
        } else {
           return createdAt
        }
    }
    
    func updatedAtFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: updatedAt) {
            dateFormatter.dateFormat = "MMM d, h:mm"
           return "Last updated at: " + dateFormatter.string(from: date)
        } else {
           return updatedAt
        }
    }
}
