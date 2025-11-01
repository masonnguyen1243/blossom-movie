//
//  DataFetcher.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 1/11/25.
//

import Foundation

let tmdbBaseUrl = APIConfig.shared?.tmdbBaseUrl
let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey

func fetchTitles(for media: String) async throws -> [Title] {
    guard let baseUrl = tmdbBaseUrl else {
        throw NetworkErrors.missingConfig
    }
    
    guard let apiKey = tmdbAPIKey else {
        throw NetworkErrors.missingConfig
    }
          
    guard let fetchTitleURL = URL(string: baseUrl)?
        .appending(path: "3/trending/\(media)/day")
        .appending(queryItems: [
            URLQueryItem(name: "api_key", value: apiKey)
        ]) else {
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
    return try decoder.decode(APIObject.self, from: data).results
}
