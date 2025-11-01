//
//  Errors.swift
//  BlossomMovie
//
//  Created by Cường Nguyễn Bá on 1/11/25.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "APIConfig.json file not found."
        case .dataLoadingFailed(let underlyingError):
            return "Failed to load data: \(underlyingError.localizedDescription)"
        case .decodingFailed(let underlyingError):
            return "Failed to decode APIConfig: \(underlyingError.localizedDescription)"
        }
    }
}

enum NetworkErros: Error, LocalizedError {
    case badUrlResponse(underlyingError: Error)
    case missingConfig
    
    var errorDescription: String? {
        switch self {
        case .badUrlResponse(underlyingError: let error):
            return "Failed to parse url response \(error.localizedDescription)"
        case .missingConfig:
            return "Failed to load data: API Config is missing."
        }
    }
}
