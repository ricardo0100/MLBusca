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
    case fileNotFound
    case decodeError(description: String)
}

protocol APIServiceProtocol {
    func searchProduct(query: String) async throws -> SearchResponse
    func loadProduct(for productID: String) async throws -> ProductDetails
    func loadDescription(for productID: String) async throws -> ProductDescription
    func loadCategory(for productID: String) async throws -> ProductCategory
}

class APIService: APIServiceProtocol {
    func searchProduct(query: String) async throws -> SearchResponse {
        throw APIServiceError.notImplemented
    }
    
    func loadProduct(for productID: String) async throws -> ProductDetails {
        throw APIServiceError.notImplemented
    }
    
    func loadDescription(for productID: String) async throws -> ProductDescription {
        throw APIServiceError.notImplemented
    }
    
    func loadCategory(for productID: String) async throws -> ProductCategory {
        throw APIServiceError.notImplemented
    }
}
