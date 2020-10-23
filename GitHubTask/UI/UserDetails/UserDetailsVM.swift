//
//  UserDetailsVM.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation
import Combine
import Resolver

class UserDetailsVM: ObservableObject {
    
    @Injected private var service: GitRepositoryService
    @Published var repositories: [GitRepository] = []
    let author: Author
    private let cancelBag = CancelBag()
    private var currentPage = 1
    private var canLoadMore = false
    
    init(author: Author) {
        self.author = author
    }
    
    func fetchMoreRepositories() {
        if canLoadMore == false {
            return
        }
        currentPage += 1
        service.reposiroties(for: author,
                             pageNumber: currentPage)
            .sinkToResult { [weak self] result in
                switch result {
                case .success(let repos):
                    self?.canLoadMore = repos.count >= ApiConfig.defaultPageSize
                    self?.repositories += repos
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }.store(in: cancelBag)
    }
    
    func fetchRepositories() {
        service.reposiroties(for: author,
                             pageNumber: currentPage)
            .sinkToResult { [weak self] result in
                switch result {
                case .success(let repos):
                    self?.canLoadMore = repos.count >= ApiConfig.defaultPageSize
                    self?.repositories = repos
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }.store(in: cancelBag)
    }
    
}
