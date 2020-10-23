//
//  GitRepositoryService.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation
import Combine
import SwiftUI

protocol GitRepositoryService {
    func repositories(searchText: String, sortingOption: SortingKey?, pageNumber: Int) -> AnyPublisher<GitRepositoriesResponse, Error>
    func repositoryDetails(repository: GitRepository) -> AnyPublisher<GitRepositoryDetails, Error>
    func reposiroties(for author: Author, pageNumber: Int) -> AnyPublisher<[GitRepository], Error>
}

class GitRepositoryServiceImpl: GitRepositoryService, WebRepository {
    
    var session = ApiConfig.configuredURLSession()
    let cancelBag = CancelBag()
    
    func repositories(searchText: String, sortingOption: SortingKey?, pageNumber: Int) -> AnyPublisher<GitRepositoriesResponse, Error> {
        call(endpoint: ApiEndpoint.searchRepos(searchText: searchText, sortBy: sortingOption, pageNumber: pageNumber)).ensureTimeSpan(1)
    }
    
    func repositoryDetails(repository: GitRepository) -> AnyPublisher<GitRepositoryDetails, Error> {
        call(endpoint: ApiEndpoint.repoDetails(repo: repository))
    }
    
    func reposiroties(for author: Author, pageNumber: Int) -> AnyPublisher<[GitRepository], Error> {
        call(endpoint: ApiEndpoint.reposiroties(author: author))
    }
}
