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
        viewModel = SearchViewModel(apiService: MockAPIService())
        viewModel.coordinator = coordinator
    }
    
    @Test
    func testButtonIsDisabledWhenTextIsEmpty() async {
        var iterator = viewModel.isEnabled.values.makeAsyncIterator()
        let isEnabled = await iterator.next()
        
        #expect(isEnabled == false)
    }
    
    @Test
    func testButtonIsDisabledWhenTextIsNotEmpty() async {
        viewModel.didUpdateSearchText(text: "cafe")
        var iterator = viewModel.isEnabled.values.makeAsyncIterator()
        let isEnabled = await iterator.next()
        
        #expect(isEnabled == true)
    }
    
    @Test
    func testDidShowDetailsScreenWhenDidTapSearch() {
        viewModel.didTapSearch()
        #expect(coordinator.didCallShowSearchDetails)
    }
}
