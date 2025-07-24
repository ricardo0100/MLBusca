//
//  ProductDetailsContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

import Combine

protocol ProductDetailsCoordinatorProtocol: AnyObject {
    init(with product: Product)
    func show()
}

protocol ProductDetailsViewModelProtocol: AnyObject {
    var coordinator: ProductDetailsCoordinatorProtocol? { get set }
    var view: ProductDetailsViewProtocol? { get set }
    
    init(product: Product)
    
    func onViewDidLoad()
}

protocol ProductDetailsViewProtocol: AnyObject {
    var viewModel: ProductDetailsViewModelProtocol? { get set }
    
    
}
