//
//  SearchResultsContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Combine

protocol SearchResultsCoordinatorProtocol: AnyObject {
    func show(for query: String)
}

protocol SearchResultsViewModelProtocol: AnyObject {
    var coordinator: SearchResultsCoordinatorProtocol? { get set }
    var view: SearchResultsViewProtocol? { get set }
    
    var products: AnyPublisher<[Product], Never> { get }
    
    init(with text: String, apiService: APIServiceProtocol)
    
    func viewDidLoad()
}

protocol SearchResultsViewProtocol: AnyObject {
    var viewModel: SearchResultsViewModelProtocol? { get set }
    func update(with products: [Product])
}
