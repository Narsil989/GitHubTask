//
//  LoginView.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation
import SwiftUI
import Resolver
import SafariServices

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    private var cancelBag = CancelBag()
    
    var body: some View {
        SafariView(url: ApiEndpoint.auth.url()!)
            .onOpenURL(perform: { url in
                presentationMode.wrappedValue.dismiss()
            })
    }
}


struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
    
}
