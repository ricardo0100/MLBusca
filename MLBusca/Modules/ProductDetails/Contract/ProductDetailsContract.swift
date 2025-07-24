//
//  ProductDetailsContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

import Combine

protocol ProductDetailsCoordinatorProtocol: AnyObject {
    func showDetails(for product: ProductSearchItem)
}

protocol ProductDetailsViewModelProtocol: AnyObject {
    var coordinator: ProductDetailsCoordinatorProtocol? { get set }
    var view: ProductDetailsViewProtocol? { get set }
    
    var productItem: AnyPublisher<ProductSearchItem, Never> { get }
    var productDetails: AnyPublisher<ProductDetails?, Never> { get }
    var productCategory: AnyPublisher<ProductCategory?, Never> { get }
    var productDescription: AnyPublisher<ProductDescription?, Never> { get }
    
    init(with product: ProductSearchItem, apiService: APIServiceProtocol)
    
    func viewDidLoad()
}

protocol ProductDetailsViewProtocol: AnyObject {
    var viewModel: ProductDetailsViewModelProtocol? { get set }
}
