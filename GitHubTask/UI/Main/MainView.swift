//
//  MainView.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import SwiftUI
import Combine
import Resolver
import Foundation
import KingfisherSwiftUI

struct MainView: View {
    
    @ObservedObject var mainVM: MainVM = MainVM()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $mainVM.searchQuery.onSet({ _ in
                    mainVM.simpleSearch()
                }))
                SortScroller(selectedSort: $mainVM.selectedSort.onSet({ _ in
                    mainVM.simpleSearch()
                }))
                RepositoriesList(repos: mainVM.currentState.repos, isLoading: mainVM.currentState.isLoading, onScrolledAtBottom: {
                    mainVM.fetchNextPageIfPossible()
                }, retryAction: {
                    mainVM.simpleSearch()
                }, error: mainVM.currentState.loadingError)
            }
            .navigationBarTitle("Git repositories", displayMode: .inline)
        }
        
    }
}

struct RepositoriesList: View {
    let repos: [GitRepository]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void
    let retryAction: () -> Void
    var error: Error?
    
    var body: some View {
        if let loadingError = error {
            VStack {
                Spacer()
                ErrorView(error: loadingError, retryAction: retryAction)
                Spacer()
            }
        } else {
            if repos.count == 0 {
                Spacer()
                if isLoading {
                    loadingIndicator
                    Text("Please wait, loading....")
                } else {
                    Text("No items to show at the moment")
                }
                Spacer()
            } else {
                List {
                    reposList
                    if isLoading {
                        loadingIndicator
                    }
                }
            }
        }
    }
    
    private var reposList: some View {
        ForEach(repos) { repo in
            RepositoryItemView(gitRepo: repo).onAppear(perform: {
                if repos.isLastItem(repo) {
                    self.onScrolledAtBottom()
                }
            })
        }.animation(.default)
    }
    
    private var loadingIndicator: some View {
        ActivityIndicatorView()
    }
}
