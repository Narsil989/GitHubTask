//
//  SortScroller.swift
//  GitHubTask
//
//  Created by Dejan on 20/10/2020.
//

import Foundation
import SwiftUI

struct SortScroller: View {
    
    var keys: [SortingKey] = SortingKey.allCases
    @Binding var selectedSort: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 16, content: {
            ForEach(0..<keys.count) { key in
                Button(action: {
                    selectedSort = key
                }, label: {
                    Text(keys[key].rawValue)
                })
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(selectedSort == key ? Color.gray : Color.white)
                .cornerRadius(20.0)
            }
        })
    }
}

struct SortScroller_Previews: PreviewProvider {
    static var previews: some View {
        SortScroller(selectedSort: .constant(0))
    }
}
