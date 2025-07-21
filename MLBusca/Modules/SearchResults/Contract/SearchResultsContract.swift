//
//  SearchResultsContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit

protocol SearchResultsCoordinatorProtocol: AnyObject {
    func show(for query: String)
}

protocol SearchResultsViewModelProtocol: AnyObject {
    var coordinator: SearchResultsCoordinatorProtocol? { get set }
    var view: SearchResultsViewProtocol? { get set }
    
    init(with text: String)
}

protocol SearchResultsViewProtocol: AnyObject {
    var viewModel: SearchResultsViewModelProtocol? { get set }
}
