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
    
    private var suggestions: [String] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var searchTextfield: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Buscar"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buscar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    required init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.addSubview(searchTextfield)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextfield.heightAnchor.constraint(equalToConstant: 40),

            searchButton.topAnchor.constraint(equalTo: searchTextfield.bottomAnchor, constant: 12),
            searchButton.centerXAnchor.constraint(equalTo: searchTextfield.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: searchTextfield)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] text in
                self?.viewModel?.didUpdateSearchText(text: text)
            }
            .store(in: &cancellables)
        
        viewModel?.isEnabled
            .receive(on: RunLoop.main)
            .sink { [weak self] isEnabled in
                self?.searchButton.isEnabled = isEnabled
            }
            .store(in: &cancellables)
        
        viewModel?.searchSuggestions
            .receive(on: RunLoop.main)
            .sink { [weak self] suggestions in
                self?.suggestions = suggestions
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc private func didTapSearchButton() {
       viewModel?.didTapSearch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        suggestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let suggestion = suggestions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = suggestion
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestion = suggestions[indexPath.row]
        viewModel?.didSelectSuggestion(suggestion: suggestion)
    }
}
