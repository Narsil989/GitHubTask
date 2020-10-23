//
//  RespositoryDetailsView.swift
//  GitHubTask
//
//  Created by Dejan on 20/10/2020.
//

import Foundation
import SwiftUI
import Resolver

struct RespositoryDetailsView: View {
    
    @ObservedObject var detailsVM: RespositoryDetailsVM
    
    init(repository: GitRepository) {
        detailsVM = RespositoryDetailsVM(gitRepository: repository)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            HStack(spacing: 8) {
                Text(detailsVM.details?.fullName ?? "").font(.largeTitle)
                Spacer()
                if let author =  detailsVM.details?.author {
                    AuthorView(author: author)
                }
            }
            .padding(.bottom, 16)
            Text(detailsVM.details?.language ?? "")
                .font(.subheadline)
            Text(detailsVM.details?.repoDescription ?? "No details available")
                .font(.subheadline)
            Spacer()
            Text(detailsVM.details?.createdAtFormatted() ?? "No details available")
                .font(.subheadline)
            Text(detailsVM.details?.updatedAtFormatted() ?? "No details available")
                .font(.subheadline)
            BrowserLinkView(url: detailsVM.details?.htmlUrl ?? "", title: "Visit repository")
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
        })
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .onAppear(perform: {
            detailsVM.fetchDetails()
        })
        .navigationBarTitle(detailsVM.details?.fullName ?? "", displayMode: .automatic)
    }
}
