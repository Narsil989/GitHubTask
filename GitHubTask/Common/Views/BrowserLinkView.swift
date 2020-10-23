//
//  BrowserLinkView.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation
import SwiftUI

struct BrowserLinkView: View {
    let url: String
    var title: String = ""
    
    var body: some View {
        if let linkUrl = URL(string: url),
           let googleUrl = linkUrl.googleURL() {
            if UIApplication.shared.canOpenURL(googleUrl) {
                Link(title,
                     destination: googleUrl)
                    .font(.footnote)
                    .foregroundColor(.red)
            } else {
                Link(title,
                     destination: linkUrl)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
        } else {
            EmptyView()
        }
    }
}
