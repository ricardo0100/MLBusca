//
//  SearchViewModel.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import Foundation
import Combine

final class SearchViewModel: SearchViewModelProtocol {
    var searchText: CurrentValueSubject<String, Never> = .init("")
    var isEnabled: CurrentValueSubject<Bool, Never> = .init(false)
    
    var coordinator: SearchCoordinatorProtocol?
    weak var view: SearchViewProtocol?
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    private func bind() {
        searchText
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .sink { [weak self] isEmpty in
                self?.isEnabled.value = !isEmpty
            }
            .store(in: &cancellables)
    }
    
    func didTapSearch() {
        coordinator?.showSearchDetails(for: searchText.value)
    }
}

