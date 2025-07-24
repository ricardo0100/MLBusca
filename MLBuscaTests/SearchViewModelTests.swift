//
//  MLBuscaTests.swift
//  MLBuscaTests
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Testing
import UIKit
@testable import MLBusca

struct SearchViewModelTests {
    let viewModel: SearchViewModelProtocol
    let coordinator = SearchCoordinatorSpy()
    
    init() {
        viewModel = SearchViewModel()
        viewModel.coordinator = coordinator
    }
    
    @Test
    func testButtonIsDisabledWhenTextIsEmpty() {
        viewModel.searchText.value = ""
        #expect(!viewModel.isEnabled.value)
    }
    
    @Test
    func testButtonIsDisabledWhenTextIsNotEmpty() {
        viewModel.searchText.value = "Café"
        #expect(viewModel.isEnabled.value)
    }
    
    @Test
    func testDidShowDetailsScreenWhenDidTapSearch() {
        viewModel.didTapSearch()
        #expect(coordinator.didCallShowSearchDetails)
    }
}
