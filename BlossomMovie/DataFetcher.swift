//
//  DataFetcher.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 1/11/25.
//

import Foundation

struct DataFetcher {
    let tmdbBaseUrl = APIConfig.shared?.tmdbBaseUrl
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    let youtubeSearchUrl = APIConfig.shared?.youtubeSearchUrl
    let youtubeAPIKey = APIConfig.shared?.youtubeAPIKey
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=YOUR_API_KEY
    //https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY
    //https://api.themoviedb.org/3/movie/upcoming?api_key=YOUR_API_KEY
    //https://api.themoviedb.org/3/search/movie?api_key=YourKey&query=PulpFiction
    
    func fetchTitles(for media: String, by type: String, with title: String? = nil) async throws -> [Title] {
        let fetchTitleURL = try buildURL(media: media, type: type, searchPhrase: title)
        
        guard let fetchTitleURL = fetchTitleURL else {
            throw NetworkErrors.urlBuildFailed
        }
        
        print(fetchTitleURL)
        var titles = try await fetchAndDecode(url: fetchTitleURL, type: TMDBAPIObject.self).results
        
        
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
    func fetchVideoId(for title: String) async throws -> String {
        guard let baseSearchUrl = youtubeSearchUrl else {
            throw NetworkErrors.missingConfig
        }
        
        guard let searchApiKey = youtubeAPIKey else {
            throw NetworkErrors.missingConfig
        }
        
        let trailerSearch = title + YoututbeURLStrings.space.rawValue + YoututbeURLStrings.trailer.rawValue
        
        guard let fetchVideoUrl = URL(string: baseSearchUrl)?
            .appending(queryItems: [
                URLQueryItem(name: YoututbeURLStrings.queryShorten.rawValue, value: trailerSearch),
                URLQueryItem(name: YoututbeURLStrings.key.rawValue, value: searchApiKey)
            ])else {
                throw NetworkErrors.urlBuildFailed
        }
        
        print(fetchVideoUrl)
        
        return try await fetchAndDecode(url: fetchVideoUrl, type: YoutubeSearchResponse.self)
            .items?.first?.id?.videoId ?? ""
    }
    
    func fetchAndDecode<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        let(data, urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkErrors.badUrlResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTPP Response"]
            ))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
    
    private func buildURL(media: String, type: String, searchPhrase: String? = nil) throws -> URL? {
        guard let baseUrl = tmdbBaseUrl else {
            throw NetworkErrors.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else {
            throw NetworkErrors.missingConfig
        }
        
        var path: String
        if type == "trending" {
            path = "3/\(type)/\(media)/day"
        }else if type == "top_rated" || type == "upcoming" {
            path = "3/\(media)/\(type)"
        }else if type == "search" {
            path = "3/\(type)/\(media)"
        }else {
            throw NetworkErrors.urlBuildFailed
        }
        
        var urlQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        if let searchPhrase {
            urlQueryItems.append(URLQueryItem(name: "query", value: searchPhrase))
        }
        
        guard let url = URL(string: baseUrl)?
            .appending(path: path)
            .appending(queryItems: urlQueryItems) else {
            throw NetworkErrors.urlBuildFailed
        }
        
        return url
    }
}

