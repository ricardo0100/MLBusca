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
    
    let productItem: AnyPublisher<ProductSearchItem, Never>
    var productDetails: AnyPublisher<ProductDetails?, Never>
    let productCategory: AnyPublisher<ProductCategory?, Never>
    let productDescription: AnyPublisher<ProductDescription?, Never>
    
    private let apiService: APIServiceProtocol
    private let productItemSubject: CurrentValueSubject<ProductSearchItem, Never>
    private let productDetailsSubject: CurrentValueSubject<ProductDetails?, Never>
    private let productCategorySubject: CurrentValueSubject<ProductCategory?, Never>
    private let productDescriptionSubject: CurrentValueSubject<ProductDescription?, Never>
    
    required init(with product: ProductSearchItem, apiService: APIServiceProtocol) {
        self.apiService = apiService
        productItemSubject = .init(product)
        productDetailsSubject = .init(nil)
        productCategorySubject = .init(nil)
        productDescriptionSubject = .init(nil)
        
        self.productItem = productItemSubject.eraseToAnyPublisher()
        self.productDetails = productDetailsSubject.eraseToAnyPublisher()
        self.productCategory = productCategorySubject.eraseToAnyPublisher()
        self.productDescription = productDescriptionSubject.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        loadProduct()
        loadCategory()
        loadDescription()
    }
    
    private func loadProduct() {
        Task {
            do {
                let product = productItemSubject.value
                let details = try await apiService.loadProduct(for: product.id)
                productDetailsSubject.send(details)
            } catch {
                print(error)
            }
        }
    }
    
    private func loadCategory() {
        Task {
            do {
                let product = productItemSubject.value
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
                let product = productItemSubject.value
                let description = try await apiService.loadDescription(for: product.id)
                productDescriptionSubject.send(description)
            } catch {
                print(error)
            }
        }
    }
}
