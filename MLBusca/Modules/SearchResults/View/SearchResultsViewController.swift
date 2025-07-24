//
//  SearchResultsViewController.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit
import Combine

class SearchResultsViewController: UITableViewController, SearchResultsViewProtocol {
    private let cellID = "SearchResultsCell"
    var viewModel: SearchResultsViewModelProtocol?
    private var cancellables: Set<AnyCancellable> = []
    private var productsDataSource: [Product] = []
    
    required init(viewModel: SearchResultsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupUI()
        viewModel?.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: cellID)
    }
    
    private func setupUI() {
        viewModel?
            .products
            .receive(on: RunLoop.main)
            .sink { _ in
            } receiveValue: { products in
                self.update(with: products)
            }
            .store(in: &cancellables)
    }
    
    func update(with products: [Product]) {
        productsDataSource = products
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! SearchResultsCell
        cell.configure(with: productsDataSource[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(product: productsDataSource[indexPath.row])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
