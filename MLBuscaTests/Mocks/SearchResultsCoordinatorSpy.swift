//
//  SearchResultsCoordinatorSpy.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

@testable import MLBusca

class SearchResultsCoordinatorSpy: SearchResultsCoordinatorProtocol {
    var didShowProductDetailsCalled = false
    var didShowCalled = false
    
    func show(for query: String) {
        didShowCalled = true
    }
    
    func showProductDetails(for product: MLBusca.Product) {
        didShowProductDetailsCalled = true
    }
}
