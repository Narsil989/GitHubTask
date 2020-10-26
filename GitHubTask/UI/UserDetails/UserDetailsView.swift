//
//  UserDetailsView.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation
import SwiftUI
import Resolver

struct UserDetailsView: View {
    
    @ObservedObject var detailsVM: UserDetailsVM
    
    init(author: Author) {
        detailsVM = UserDetailsVM(author: author)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16, content: {
            AuthorAvatarView(avatarUrl: detailsVM.author.avatar)
            Text(detailsVM.author.name).font(.largeTitle)
            Spacer()
            VStack(alignment: .leading, content: {
                Section {
                    Text("User repositories").font(.title)
                }
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
                List {
                    ForEach(detailsVM.repositories) { repo in
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                            NavigationLink(
                                destination: RespositoryDetailsView(repository: repo),
                                label: {
                                    EmptyView()
                                        .background(Color.LightGrey)
                                })
                            Text(repo.name).font(.title3).background(Color.clear)
                        })
                        .background(Color.LightGrey)
                        .onAppear(perform: {
                            if detailsVM.repositories.isThresholdItem(offset: 2, item: repo) {
                                detailsVM.fetchMoreRepositories()
                            }
                        })
                        .listRowBackground(Color.LightGrey)
                    }
                }
            })
            .background(Color.LightGrey)
            BrowserLinkView(url: detailsVM.author.userUrl, title: "Visit user on web")
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0))
        })
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .onAppear(perform: {
            detailsVM.fetchRepositories()
        })
        .navigationBarTitle(detailsVM.author.name, displayMode: .automatic)
    }
}
