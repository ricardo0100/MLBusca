//
//  SearchViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Foundation
import Combine

final class SearchViewModel: SearchViewModelProtocol {
    var coordinator: SearchCoordinatorProtocol?
    weak var view: SearchViewProtocol?
    
    func didChangeSearchText(query: String) {
        coordinator?.showSearchDetails(for: query)
    }
}
