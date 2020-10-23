//
//  MainVM.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation
import Combine
import Resolver
import SwiftUI

class MainVM: ObservableObject {
    
    @Published private(set) var currentState = State()
    @Injected private var service: GitRepositoryService
    var searchQuery: String = ""
    var selectedSort: Int = 0
    //private var isLoading = false
    
    private var cancelBag = CancelBag()
    
    struct State {
        var repos: [GitRepository] = []
        var page: Int = 1
        var canLoadNextPage = true
        var isLoading = false
        var loadingError: Error? = nil
    }
    
    func simpleSearch() {
        guard currentState.canLoadNextPage else { return }
        
        if currentState.isLoading == true {
            print("itens loading")
            return
        }
        currentState.isLoading = true
        currentState.page = 1
        currentState.repos = []
        service.repositories(searchText: searchQuery,
                             sortingOption: SortingKey.allCases[selectedSort],
                             pageNumber: currentState.page)
            .sinkToResult { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let repos):
                        self?.currentState.repos = repos.items
                        self?.currentState.canLoadNextPage = repos.totalCount > repos.items.count
                        self?.currentState.loadingError = nil
                    case .failure(let err):
                        self?.currentState.loadingError = err
                    }
                    self?.currentState.isLoading = false
                }
            }.store(in: cancelBag)
    }
    
    func fetchNextPageIfPossible() {
        guard currentState.canLoadNextPage else { return }
        
        if currentState.isLoading == true {
            print("itens loading")
            return
        }
        currentState.isLoading = true
        currentState.page += 1
        service.repositories(searchText: searchQuery,
                             sortingOption: SortingKey.allCases[selectedSort],
                             pageNumber: currentState.page)
            .sinkToResult { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let repos):
                        self?.currentState.repos += repos.items
                        self?.currentState.canLoadNextPage = repos.totalCount > repos.items.count
                        self?.currentState.loadingError = nil
                    case .failure(let err):
                        self?.currentState.loadingError = err
                    }
                    self?.currentState.isLoading = false
                }
            }.store(in: cancelBag)
    }
}
