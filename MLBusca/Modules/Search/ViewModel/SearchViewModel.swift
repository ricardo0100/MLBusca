//
//  SearchViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Foundation
import Combine

final class SearchViewModel: SearchViewModelProtocol {
    private var searchTextSubject: CurrentValueSubject<String, Never> = .init("")
    private var searchSuggestionsSubject: CurrentValueSubject<[String], Never> = .init([])
    private let apiService: APIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    var searchText: AnyPublisher<String, Never>
    var isEnabled: AnyPublisher<Bool, Never>
    var searchSuggestions: AnyPublisher<[String], Never>
    
    var coordinator: SearchCoordinatorProtocol?
    weak var view: SearchViewProtocol?
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        searchText = searchTextSubject.eraseToAnyPublisher()
        isEnabled = searchText.map { !$0.isEmpty }.eraseToAnyPublisher()
        searchSuggestions = searchSuggestionsSubject.eraseToAnyPublisher()
        searchTextSubject
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task {
                    do {
                        let suggestions = try await self?.apiService.loadSearchSuggestions(query: query) ?? []
                        self?.searchSuggestionsSubject.value = suggestions
                    } catch {
                        print(error)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func didSelectSuggestion(suggestion: String) {
        coordinator?.showSearchDetails(for: suggestion)
    }
    
    func didUpdateSearchText(text: String) {
        searchTextSubject.value = text
    }
    
    func didTapSearch() {
        coordinator?.showSearchDetails(for: searchTextSubject.value)
    }
}

