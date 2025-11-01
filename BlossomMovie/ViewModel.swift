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
    private(set) var videoIdStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    var heroTitle = Title.previewTitles[0]
    var videoId = ""
    
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
                
                if let title = trendingMovies.randomElement() {
                        heroTitle = title
                }
                
                homeStatus = .success
            }catch {
                print(error)
                homeStatus = .failure(underlyingError: error)
            }
        } else {
            homeStatus = .success
        }
        
    }
    
    func getVideoId(for title: String) async {
            videoIdStatus = .fetching
        
        do {
            videoId = try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = .success
            print("✅ Video ID:", videoId)
        }catch {
            print(error)
            print("❌ Error:", error)
            videoIdStatus = .failure(underlyingError: error)
        }
    }
        
}
