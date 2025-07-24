//
//  ProductDetailsViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    var coordinator: ProductDetailsCoordinatorProtocol?
    weak var view: ProductDetailsViewProtocol?
    
    required init(product: Product) {
        
    }
    
    func onViewDidLoad() {
        
    }
}
