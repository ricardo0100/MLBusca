//
//  ProductDetailsViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//
import Combine

class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    var coordinator: ProductDetailsCoordinatorProtocol?
    weak var view: ProductDetailsViewProtocol?
    
    let product: AnyPublisher<Product, Never>
    var productCategory: AnyPublisher<ProductCategory?, Never>
    
    private let productSubject: CurrentValueSubject<Product, Never>
    private let productCategorySubject: CurrentValueSubject<ProductCategory?, Never>
    
    required init(with product: Product, apiService: APIServiceProtocol) {
        productSubject = .init(product)
        productCategorySubject = .init(nil)
        
        self.product = productSubject.eraseToAnyPublisher()
        self.productCategory = productCategorySubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        
    }
}
