//
//  ProductDetailsViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//
import Combine
import Foundation

class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    var coordinator: ProductDetailsCoordinatorProtocol?
    weak var view: ProductDetailsViewProtocol?
    
    var productTitle: AnyPublisher<String, Never>
    var productPath: AnyPublisher<String, Never>
    var productImages: AnyPublisher<[URL], Never>
    var productPrice: AnyPublisher<String, Never>
    var productDescription: AnyPublisher<String, Never>
    
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
        
        productTitle = productDetailsSubject
            .compactMap { $0 }
            .map { $0.title }
            .eraseToAnyPublisher()
        
        productPath = productCategorySubject
            .compactMap { $0?.pathFromRoot }
            .map { $0.map { $0.name }.reduce("") { $0.appending("/").appending($1) } }
            .eraseToAnyPublisher()
        
        productImages = productDetailsSubject
            .compactMap { $0?.pictures }
            .map { pictures in
                pictures.compactMap { URL(string: $0.url) }
            }
            .eraseToAnyPublisher()

        productPrice = productDetailsSubject
            .compactMap { $0 }
            .map { details in
                details.price.formatted(.currency(code: details.currencyID))
            }
            .eraseToAnyPublisher()

        productDescription = productDescriptionSubject
            .compactMap { $0?.plainText }
            .eraseToAnyPublisher()
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
