//
//  SearchCoordinator.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit

final class SearchCoordinator: SearchCoordinatorProtocol {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    static func start(in navigationController: UINavigationController) {
        let viewModel = SearchViewModel()
        viewModel.coordinator = SearchCoordinator(navigationController: navigationController)
        let view = SearchViewController(viewModel: viewModel)
        
        view.viewModel = viewModel
        viewModel.view = view
        navigationController.pushViewController(view, animated: true)
    }

    func showSearchDetails(for query: String) {
        print("Details not implemented. query: \(query)")
    }
}
