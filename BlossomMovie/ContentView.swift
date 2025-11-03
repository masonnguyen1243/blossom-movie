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
                UpcomingView()
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconString) {
                SearchView()
            }
            Tab(Constants.downloadString, systemImage: Constants.downloadIconString) {
                DownloadView()
            }
        }
        .onAppear {
            if let config = APIConfig.shared {
                print(config.tmdbAPIKey)
                print(config.tmdbBaseUrl)
            }
        }
    }
}

#Preview {
    ContentView()
}
