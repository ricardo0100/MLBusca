//
//  ProductDetailsViewController.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 23/07/25.
//

import UIKit
import Combine

class ProductDetailsViewController: UIViewController, ProductDetailsViewProtocol {
    var viewModel: ProductDetailsViewModelProtocol?
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindPublishers()
        viewModel?.viewDidLoad()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
    }
    
    private func bindPublishers() {
        viewModel?.product.sink { [weak self] product in
            self?.updateView(with: product)
        }.store(in: &cancellables)
    }
    
    private func updateView(with product: ProductSearchItem) {
        title = product.title
    }
}
