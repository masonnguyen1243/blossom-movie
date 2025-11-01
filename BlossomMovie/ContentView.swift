//
//  ContentView.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 30/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constants.homeString, systemImage: Constants.homeIconString) {
               HomeView()
            }
            Tab(Constants.upCommingString, systemImage: Constants.upCommingIconString) {
                Text(Constants.upCommingString)
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconString) {
                Text(Constants.searchString)
            }
            Tab(Constants.downloadString, systemImage: Constants.downloadIconString) {
                Text(Constants.downloadString)
            }
        }
        .onAppear {
            print(APIConfig.shared.tmdbAPIKey)
            print(APIConfig.shared.tmdbBaseUrl)
        }
    }
}

#Preview {
    ContentView()
}
