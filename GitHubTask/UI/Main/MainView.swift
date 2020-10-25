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
            .navigationBarItems(trailing: (
                loggedInView()
            ))
        }.onOpenURL(perform: { url in
            if let code = url.valueOf("code") {
                mainVM.requestAccessToken(code: code)
            }
        })
        
    }
    
    private func loggedInView() -> AnyView {
        if let user = mainVM.currentState.authorizedUser {
            return AnyView(
                NavigationLink(
                    destination: UserDetailsView(author: user),
                    label: {
                        Text(user.name)
                    }))
        } else {
            return AnyView(
                NavigationLink(
                    destination: LoginView(),
                    label: {
                        Text("LOGIN")
                    }))
        }
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
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
                VStack {
                    if isLoading {
                        loadingIndicator
                    }
                    List {
                        reposList
                    }
                    .animation(.easeIn)
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
        }
    }
    
    private var loadingIndicator: some View {
        ActivityIndicatorView()
    }
}
