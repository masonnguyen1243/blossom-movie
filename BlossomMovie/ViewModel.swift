//
//  ViewModel.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 1/11/25.
//

import Foundation

@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failure(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    
    func getTitle() async {
        homeStatus = .fetching
        if trendingMovies.isEmpty {
            do {
                async let tMovies = try await dataFetcher.fetchTitles(for: "movie", by: "trending")
                async let tTV = try await dataFetcher.fetchTitles(for: "tv", by: "trending")
                async let tRMovies = try await dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let tRTV = try await dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                
                trendingMovies = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await tRMovies
                topRatedTV = try await tRTV
                
                homeStatus = .success
            }catch {
                print(error)
                homeStatus = .failure(underlyingError: error)
            }
        } else {
            homeStatus = .success
        }
        
    }
        
}
