//
//  SearchViewModel.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 3/11/25.
//

import Foundation

@Observable
class SearchViewModel {
    private(set) var errorMessage: String?
    private(set) var searchTitle: [Title] = []
    private let dataFetcher = DataFetcher()
    
    func getSearchTitle(by media: String, for title: String) async {
        do {
            errorMessage = nil
            if title.isEmpty {
                searchTitle = try await dataFetcher.fetchTitles(for: media, by: "trending")
            }else {
                searchTitle = try await dataFetcher.fetchTitles(for: media, by: "search", with: title)
            }
        }catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}
