//
//  SearchResultsContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Combine

protocol SearchResultsCoordinatorProtocol: AnyObject {
    func show(for query: String)
    func showProductDetails(for product: ProductSearchItem)
}

protocol SearchResultsViewModelProtocol: AnyObject {
    var coordinator: SearchResultsCoordinatorProtocol? { get set }
    var view: SearchResultsViewProtocol? { get set }
    
    var products: AnyPublisher<[ProductSearchItem], Never> { get }
    
    init(with text: String, apiService: APIServiceProtocol)
    
    func viewDidLoad()
    func didSelect(product: ProductSearchItem)
}

protocol SearchResultsViewProtocol: AnyObject {
    var viewModel: SearchResultsViewModelProtocol? { get set }
    func update(with products: [ProductSearchItem])
}
