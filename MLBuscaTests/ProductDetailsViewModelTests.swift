//
//  ProductDetailsViewModelTests.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 24/07/25.
//
import Testing
@testable import MLBusca

struct ProductDetailsViewModelTests {
    @Test
    func viewDidLoad_fetchesProductDetails() async throws {
        let item = ProductSearchItem(id: "MLA738241667", title: "", thumbnail: "", currencyID: "", price: 1)
        let viewModel = ProductDetailsViewModel(with: item, apiService: MockAPIService())
        viewModel.viewDidLoad()
        try await Task.sleep(nanoseconds: 300_000_000)
        
        var iterator = viewModel.productTitle.values.makeAsyncIterator()
        let title = await iterator.next()
        
        #expect(title == "Camisa Hombre Lisa Color Manga Larga Variedad De Colores")
    }
    
    // TODO: Test all publishers
}
