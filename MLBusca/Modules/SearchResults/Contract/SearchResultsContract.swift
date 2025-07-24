//
//  SearchResultsContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Combine

protocol SearchResultsCoordinatorProtocol: AnyObject {
    func show(for query: String)
    func showProductDetails(for product: Product)
}

protocol SearchResultsViewModelProtocol: AnyObject {
    var coordinator: SearchResultsCoordinatorProtocol? { get set }
    var view: SearchResultsViewProtocol? { get set }
    
    var products: AnyPublisher<[Product], Never> { get }
    
    init(with text: String, apiService: APIServiceProtocol)
    
    func viewDidLoad()
    func didSelect(product: Product)
}

protocol SearchResultsViewProtocol: AnyObject {
    var viewModel: SearchResultsViewModelProtocol? { get set }
    func update(with products: [Product])
}
