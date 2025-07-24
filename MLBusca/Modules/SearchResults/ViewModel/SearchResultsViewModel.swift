//
//  SearchResultsViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Foundation
import Combine

final class SearchResultsViewModel: SearchResultsViewModelProtocol {
    var coordinator: SearchResultsCoordinatorProtocol?
    weak var view: SearchResultsViewProtocol?
    
    private let apiService: APIServiceProtocol
    private let searchText: String
    
    var products: AnyPublisher<[ProductSearchItem], Never>
    var productsSubject: CurrentValueSubject<[ProductSearchItem], Never>
    
    init(with text: String, apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.searchText = text
        self.productsSubject = CurrentValueSubject([])
        self.products = productsSubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        Task {
            do {
                let searchResponse = try await apiService.searchProduct(query: searchText)
                productsSubject.value = searchResponse.results
            } catch {
                print("Erro ao buscar produtos: \(error)")
            }
        }
    }
    
    func didSelect(product: ProductSearchItem) {
        coordinator?.showProductDetails(for: product)
    }
}
