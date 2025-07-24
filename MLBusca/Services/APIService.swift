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
    func loadDescription(for productID: String) async throws -> ProductDescriptionResponse
    func loadCategory(for productID: String) async throws -> ProductCategory
}

class APIService: APIServiceProtocol {
    func searchProduct(query: String) async throws -> SearchResponse {
        throw APIServiceError.notImplemented
    }
    
    func loadDescription(for productID: String) async throws -> ProductDescriptionResponse {
        throw APIServiceError.notImplemented
    }
    
    func loadCategory(for productID: String) async throws -> ProductCategory {
        throw APIServiceError.notImplemented
    }
}
