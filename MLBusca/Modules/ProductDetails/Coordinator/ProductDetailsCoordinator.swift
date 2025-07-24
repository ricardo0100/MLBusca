//
//  ProductDetailsCoordinator.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//
import UIKit

class ProductDetailsCoordinator: ProductDetailsCoordinatorProtocol {
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showDetails(for product: Product) {
        let viewModel = ProductDetailsViewModel(with: product, apiService: MockAPIService())
        viewModel.coordinator = self
        let viewController = ProductDetailsViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
