//
//  APIService.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 21/07/25.
//

import Foundation

enum APIServiceError: Error {
    case notImplemented
    case noResultsFound
}

protocol APIServiceProtocol {
    func searchProduct(query: String) async throws -> SearchResponse
}

class APIService: APIServiceProtocol {
    func searchProduct(query: String) async throws -> SearchResponse {
        throw APIServiceError.notImplemented
    }
}
