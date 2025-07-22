//
//  SearchResultsViewController.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit
import Combine

class SearchResultsViewController: UIViewController, SearchResultsViewProtocol {
    var viewModel: SearchResultsViewModelProtocol?
    private var cancellables: Set<AnyCancellable> = []
    
    required init(viewModel: SearchResultsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        viewModel?.viewDidLoad()
    }
    
    private func setupUI() {
        viewModel?
        .products
        .receive(on: RunLoop.main)
        .sink { _ in
        } receiveValue: { products in
            self.update(with: products)
        }.store(in: &cancellables)
    }
    
    func update(with products: [Product]) {
        print(products)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
