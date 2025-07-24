//
//  APIServiceMock.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 21/07/25.
//

import Foundation
import Combine

class MockAPIService: APIServiceProtocol {
    private var files: [URL] = []
    
    init() {
        files = listJSONFiles()
    }
    
    func searchProduct(query: String) async throws -> SearchResponse {
        let query = query.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = files.filter({ $0.path().contains("search-MLA") && $0.path().contains(query) }).first else {
            throw APIServiceError.noResultsFound
        }
        if let contents = readJSONFile(in: url, as: SearchResponse.self) {
            return contents
        } else {
            throw APIServiceError.noResultsFound
        }
    }
    
    func loadCategory(for productID: String) async throws -> ProductCategory {
        let filename = "item-\(productID)-category.json"
        
        guard let fileURL = files.first(where: { $0.lastPathComponent == filename }) else {
            throw APIServiceError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(ProductCategory.self, from: data)
        } catch {
            throw APIServiceError.decodeError
        }
    }
    
    func loadDescription(for productID: String) async throws -> ProductDescriptionResponse {
        throw APIServiceError.notImplemented
    }
    
    private func listJSONFiles(in subdirectory: String? = nil) -> [URL] {
        guard let bundleURL = Bundle.main.resourceURL else {
            print("❌ Bundle URL não encontrada.")
            return []
        }

        let targetURL = subdirectory != nil
            ? bundleURL.appendingPathComponent(subdirectory!)
            : bundleURL

        do {
            let fileManager = FileManager.default
            let contents = try fileManager.contentsOfDirectory(at: targetURL, includingPropertiesForKeys: nil)

            let jsonFiles = contents.filter { $0.pathExtension == "json" }

            return jsonFiles
        } catch {
            print("❌ Erro ao listar arquivos .json: \(error)")
            return []
        }
    }
    
    private func readJSONFile<T: Decodable>(in url: URL, as type: T.Type) -> T? {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ Erro ao decodificar \(url.path()).json: \(error)")
            return nil
        }
    }
}
