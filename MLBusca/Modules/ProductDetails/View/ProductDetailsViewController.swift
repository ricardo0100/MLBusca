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

    // MARK: - UI Components

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var carouselView: ImageCarouselView = {
        let view = ImageCarouselView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindPublishers()
        viewModel?.viewDidLoad()
    }

    // MARK: - Setup Views

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(carouselView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // ImageView
            carouselView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            carouselView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            carouselView.heightAnchor.constraint(equalToConstant: 250),
            carouselView.widthAnchor.constraint(equalTo: carouselView.heightAnchor),

            // TitleLabel
            titleLabel.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // PriceLabel
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Bindings

    private func bindPublishers() {
        viewModel?.productItem
            .receive(on: DispatchQueue.main)
            .sink { [weak self] product in
                self?.updateView(with: product)
            }
            .store(in: &cancellables)
        viewModel?.productDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] product in
                if let product = product {
                    self?.updateView(with: product)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Update UI
    
    private func updateView(with product: ProductSearchItem) {
        title = product.title
        titleLabel.text = product.title
        priceLabel.text = String(format: "R$ %.2f", product.price)
    }
    
    private func updateView(with product: ProductDetails) {
        if let url = URL(string: product.thumbnail) {
            carouselView.setImageURLs(product.pictures.compactMap { URL(string: $0.url) })
        }
    }
}

