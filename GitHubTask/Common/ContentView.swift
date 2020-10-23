//
//  ContentView.swift
//  GitHubTask
//
//  Created by Dejan on 19/10/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var mainVM = MainVM()
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
