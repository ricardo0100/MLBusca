//
//  SearchResultsViewSpy.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

@testable import MLBusca
import Combine

class SearchResultsViewSpy: SearchResultsViewProtocol {
    var cancellables = Set<AnyCancellable>()
    
    var products: [ProductSearchItem] = []
    
    var viewModel: SearchResultsViewModelProtocol?
    
    init(viewModel: SearchResultsViewModelProtocol) {
        self.viewModel = viewModel
        viewModel
            .products
            .setFailureType(to: Never.self)
            .sink { [weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
    }
    
    func update(with products: [MLBusca.ProductSearchItem]) {
        self.products = products
    }
}
