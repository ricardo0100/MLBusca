//
//  SearchViewController.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 20/07/25.
//

import UIKit
import Combine

class SearchViewController: UIViewController, SearchViewProtocol {
    var viewModel: SearchViewModelProtocol?
    
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var searchTextfield: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Buscar"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buscar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()
    
    required init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(searchTextfield)
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.topAnchor.constraint(equalTo: searchTextfield.bottomAnchor, constant: 12),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func didTapSearchButton() {
       guard let text = searchTextfield.text, !text.isEmpty else { return }
       viewModel?.didChangeSearchText(query: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
