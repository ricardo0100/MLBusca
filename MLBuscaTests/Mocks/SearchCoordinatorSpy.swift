//
//  SearchCoordinatorSpy.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Testing
@testable import MLBusca

class SearchCoordinatorSpy: SearchCoordinatorProtocol {
    var didCallShowSearchDetails = false
    
    func show() {}
    
    func showSearchDetails(for query: String) {
        didCallShowSearchDetails = true
    }
}
