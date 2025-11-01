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
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=YOUR_API_KEY
    //https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY
    func fetchTitles(for media: String, by type: String) async throws -> [Title] {
        let fetchTitleURL = try buildURL(media: media, type: type)
        
        guard let fetchTitleURL = fetchTitleURL else {
            throw NetworkErrors.urlBuildFailed
        }
        
        print(fetchTitleURL)
        
        let(data, urlResponse) = try await URLSession.shared.data(from: fetchTitleURL)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkErrors.badUrlResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTPP Response"]
            ))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObject.self, from: data).results
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
    private func buildURL(media: String, type: String) throws -> URL? {
        guard let baseUrl = tmdbBaseUrl else {
            throw NetworkErrors.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else {
            throw NetworkErrors.missingConfig
        }
        
        var path: String
        if type == "trending" {
            path = "3/trending/\(media)/day"
        }else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        }else {
            throw NetworkErrors.urlBuildFailed
        }
        
        guard let url = URL(string: baseUrl)?
            .appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkErrors.urlBuildFailed
        }
        
        return url
    }
}

