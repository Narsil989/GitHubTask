//
//  RespositoryDetailsVM.swift
//  GitHubTask
//
//  Created by Dejan on 20/10/2020.
//

import Foundation
import Combine
import Resolver

class RespositoryDetailsVM: ObservableObject {
    
    @Injected private var service: GitRepositoryService
    @Published var details: GitRepositoryDetails?
    let gitRepository: GitRepository
    private let cancelBag = CancelBag()
    
    init(gitRepository: GitRepository) {
        self.gitRepository = gitRepository
    }
    
    func fetchDetails() {
        service.repositoryDetails(repository: gitRepository).sinkToResult { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let details):
                self.details = details
            case .failure(let err):
                self.details = nil
                print(err)
            }
        }.store(in: cancelBag)
    }
    
}
