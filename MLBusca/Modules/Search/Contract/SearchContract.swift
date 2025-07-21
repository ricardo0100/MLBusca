//
//  SearchContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit

protocol SearchCoordinatorProtocol: AnyObject {
    static func start(in navigationController: UINavigationController)
    func showSearchDetails(for query: String)
}

protocol SearchViewModelProtocol: AnyObject {
    var coordinator: SearchCoordinatorProtocol? { get set }
    var view: SearchViewProtocol? { get set }
    
    func didChangeSearchText(query: String)
}

protocol SearchViewProtocol: AnyObject {
    var viewModel: SearchViewModelProtocol? { get set }
}
