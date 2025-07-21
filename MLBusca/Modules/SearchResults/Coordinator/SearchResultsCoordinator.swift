//
//  SearchResultsCoordinator.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit

final class SearchResultsCoordinator: SearchResultsCoordinatorProtocol {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func show(for query: String) {
        let viewModel = SearchResultsViewModel(with: query)
        viewModel.coordinator = self
        let view = SearchResultsViewController(viewModel: viewModel)
        
        view.viewModel = viewModel
        viewModel.view = view
        navigationController.pushViewController(view, animated: true)
    }
}
