//
//  BindingExt.swift
//  GitHubTask
//
//  Created by Dejan on 23/10/2020.
//

import Foundation
import SwiftUI

extension Binding {
    typealias ValueClosure = (Value) -> Void
    
    func onSet(_ perform: @escaping ValueClosure) -> Self {
        return .init(get: { () -> Value in
            self.wrappedValue
        }, set: { value in
            self.wrappedValue = value
            perform(value)
        })
    }
}
