//
//  ActivityIndicatorView.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        uiView.startAnimating()
    }
}
