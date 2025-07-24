//
//  SearchContract.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Combine

protocol SearchCoordinatorProtocol: AnyObject {
    func show()
    func showSearchDetails(for query: String)
}

protocol SearchViewModelProtocol: AnyObject {
    var coordinator: SearchCoordinatorProtocol? { get set }
    var view: SearchViewProtocol? { get set }
    
    var searchText: CurrentValueSubject<String, Never> { get }
    var isEnabled: CurrentValueSubject<Bool, Never> { get }
    
    func didTapSearch()
}

protocol SearchViewProtocol: AnyObject {
    var viewModel: SearchViewModelProtocol? { get set }
}
