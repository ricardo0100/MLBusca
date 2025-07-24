//
//  SearchCoordinator.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit

final class SearchCoordinator: SearchCoordinatorProtocol {
    let navigationController: UINavigationController
    let resultsCoordinator: SearchResultsCoordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.resultsCoordinator = SearchResultsCoordinator(navigationController: navigationController)
    }

    func show() {
        let viewModel = SearchViewModel(apiService: MockAPIService())
        let view = SearchViewController(viewModel: viewModel)
        viewModel.coordinator = self
        view.viewModel = viewModel
        viewModel.view = view
        navigationController.pushViewController(view, animated: true)
    }

    func showSearchDetails(for query: String) {
        resultsCoordinator.show(for: query)
    }
}
