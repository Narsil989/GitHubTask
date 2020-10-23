//
//  ListItemView.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import Foundation
import SwiftUI
import Combine
import KingfisherSwiftUI
import class Kingfisher.ImageCache

struct RepositoryItemView: View {
    
    var gitRepo: GitRepository
    @State private var openItemDetails: Int? = nil
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: RespositoryDetailsView(repository: gitRepo),
                tag: 2,
                selection: $openItemDetails,
                label: {
                    EmptyView()
                })
            
                Button(action: {
                    self.openItemDetails = 2
                }, label: {
                    VStack(alignment: .leading, content: {
                        Text(gitRepo.name).font(.title)
                        Text(gitRepo.language ?? "").font(.subheadline)
                        HStack(alignment: .center, content: {
                            AuthorView(author: gitRepo.author)
                            Spacer()
                            CountersView(counter: CountersView.Counters(watchers: gitRepo.watchersCount,
                                                                        forks: gitRepo.forkCount,
                                                                        issues: gitRepo.issueCount,
                                                                        stars: gitRepo.starsCount))
                        })
                    })
                })
        }

    }
}

struct AuthorView: View {
    
    var author: Author
    @State private var openAuthorDetails: Int? = nil
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            NavigationLink(
                destination: UserDetailsView(author: author),
                tag: 1,
                selection: $openAuthorDetails,
                label: {
                    EmptyView()
                })
            
                Button(action: {
                    openAuthorDetails = 1
                }, label: {
                    VStack(content: {
                        AuthorAvatarView(avatarUrl: author.avatar)
                            .frame(width: 50, height: 50)
                            .cornerRadius(20)
                        Text(author.name)
                    }).padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)).background(Color.gray).cornerRadius(10.0)
                })
        })
    }
}

struct AuthorAvatarView: View {
    var avatarUrl: String
    @State var done = false
    var alreadyCached: Bool {
        ImageCache.default.isCached(forKey: avatarUrl)
    }
    
    var body: some View {
        KFImage(URL(string: avatarUrl), isLoaded: $done)
            .resizable()
            .cancelOnDisappear(true)
            .aspectRatio(contentMode: .fit)
            .opacity(done || alreadyCached ? 1.0 : 0.3)
            .animation(.linear(duration: 0.4))
    }
}

struct CountersView: View {
    struct Counters {
        let watchers: Int
        let forks: Int
        let issues: Int
        let stars: Int
    }
    
    var counter: Counters
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            HStack(content: {
                Image("ic_eye")
                Text("\(counter.watchers)")
            })
            HStack(content: {
                Image("ic_fork")
                Text("\(counter.forks)")
            })
            HStack(content: {
                Image("ic_issue")
                Text("\(counter.issues)")
            })
        })
    }
}
