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
    
    let product: AnyPublisher<ProductSearchItem, Never>
    let productCategory: AnyPublisher<ProductCategory?, Never>
    let productDescription: AnyPublisher<ProductDescription?, Never>
    
    private let apiService: APIServiceProtocol
    private let productSubject: CurrentValueSubject<ProductSearchItem, Never>
    private let productCategorySubject: CurrentValueSubject<ProductCategory?, Never>
    private let productDescriptionSubject: CurrentValueSubject<ProductDescription?, Never>
    
    required init(with product: ProductSearchItem, apiService: APIServiceProtocol) {
        self.apiService = apiService
        productSubject = .init(product)
        productCategorySubject = .init(nil)
        productDescriptionSubject = .init(nil)
        
        self.product = productSubject.eraseToAnyPublisher()
        self.productCategory = productCategorySubject.eraseToAnyPublisher()
        self.productDescription = productDescriptionSubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        loadCategory()
        loadDescription()
    }
    
    private func loadCategory() {
        Task {
            do {
                let product = productSubject.value
                let category = try await apiService.loadCategory(for: product.id)
                productCategorySubject.send(category)
            } catch {
                print(error)
            }
        }
    }
    
    private func loadDescription() {
        Task {
            do {
                let product = productSubject.value
                let description = try await apiService.loadDescription(for: product.id)
                productDescriptionSubject.send(description)
            } catch {
                print(error)
            }
        }
    }
}
