//
//  SearchResultsViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Foundation
import Combine

final class SearchResultsViewModel: SearchResultsViewModelProtocol {
    var coordinator: SearchResultsCoordinatorProtocol?
    weak var view: SearchResultsViewProtocol?
    
    init(with text: String) {
        
    }
}
