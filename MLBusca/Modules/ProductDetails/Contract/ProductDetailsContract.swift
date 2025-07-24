//
//  ProductDetailsContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

import Combine

protocol ProductDetailsCoordinatorProtocol: AnyObject {
    func showDetails(for product: Product)
}

protocol ProductDetailsViewModelProtocol: AnyObject {
    var coordinator: ProductDetailsCoordinatorProtocol? { get set }
    var view: ProductDetailsViewProtocol? { get set }
    var product: AnyPublisher<Product, Never> { get }
    var productCategory: AnyPublisher<ProductCategory?, Never> { get }
    
    init(with product: Product, apiService: APIServiceProtocol)
    
    func viewDidLoad()
}

protocol ProductDetailsViewProtocol: AnyObject {
    var viewModel: ProductDetailsViewModelProtocol? { get set }
}
