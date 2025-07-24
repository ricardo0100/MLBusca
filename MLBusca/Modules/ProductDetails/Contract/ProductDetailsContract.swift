//
//  ProductDetailsContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

import Combine
import Foundation

protocol ProductDetailsCoordinatorProtocol: AnyObject {
    func showDetails(for product: ProductSearchItem)
}

protocol ProductDetailsViewModelProtocol: AnyObject {
    var coordinator: ProductDetailsCoordinatorProtocol? { get set }
    var view: ProductDetailsViewProtocol? { get set }
    
    var productTitle: AnyPublisher<String, Never> { get }
    var productPath: AnyPublisher<String, Never> { get }
    var productImages: AnyPublisher<[URL], Never> { get }
    var productPrice: AnyPublisher<String, Never> { get }
    var productDescription: AnyPublisher<String, Never> { get }
    var error: AnyPublisher<Error, Never> { get }
    
    init(with product: ProductSearchItem, apiService: APIServiceProtocol)
    
    func viewDidLoad()
}

protocol ProductDetailsViewProtocol: AnyObject {
    var viewModel: ProductDetailsViewModelProtocol? { get set }
}
