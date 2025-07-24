//
//  SearchResultsViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

import Testing
import UIKit
import Combine
@testable import MLBusca

struct SearchResultsViewModelTests {
    let apiService: APIServiceProtocol
    let coordinator: SearchResultsCoordinatorSpy
    var cancelables = Set<AnyCancellable>()
    
    init() {
        apiService = MockAPIService()
        coordinator = SearchResultsCoordinatorSpy()
    }
    
    @Test
    func viewDidLoad_fetchesProductsAndUpdatesView() async throws {
        let viewModel = SearchResultsViewModel(with: "iphone", apiService: apiService)
        viewModel.viewDidLoad()
        
        var iterator = viewModel.products.values.makeAsyncIterator()
        let products = await iterator.next()
        
        // TODO: Fix async testing
        #expect(products?.isEmpty == false)
    }
    
    @Test
    func didSelect_triggersCoordinator() async throws {
        let viewModel = SearchResultsViewModel(with: "iphone", apiService: apiService)
        viewModel.coordinator = coordinator
        viewModel.viewDidLoad()
        
        var iterator = viewModel.products.values.makeAsyncIterator()
        let products = await iterator.next()!
        
        viewModel.didSelect(product: products[0])
        
        // TODO: Fix async testing
        #expect(coordinator.didShowProductDetailsCalled)
    }
}
