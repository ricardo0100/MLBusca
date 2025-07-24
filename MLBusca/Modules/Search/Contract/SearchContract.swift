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
    
    var searchText: AnyPublisher<String, Never> { get }
    var isEnabled: AnyPublisher<Bool, Never> { get }
    var searchSuggestions: AnyPublisher<[String], Never> { get }
    
    func didTapSearch()
    func didUpdateSearchText(text: String)
    func didSelectSuggestion(suggestion: String)
}

protocol SearchViewProtocol: AnyObject {
    var viewModel: SearchViewModelProtocol? { get set }
}
