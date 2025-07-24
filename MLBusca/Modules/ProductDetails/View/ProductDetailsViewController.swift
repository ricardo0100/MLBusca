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
    
    private lazy var pathLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemGray
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
        
        contentView.addSubview(pathLabel)
        contentView.addSubview(carouselView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        
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

            pathLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            pathLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pathLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // CarouselView
            carouselView.topAnchor.constraint(equalTo: pathLabel.bottomAnchor, constant: 12),
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
            
            // DescriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - Bindings

    private func bindPublishers() {
        viewModel?.productTitle.receive(on: RunLoop.main).sink(receiveValue: { [weak self] title in
            self?.title = title
            self?.titleLabel.text = title
        }).store(in: &cancellables)
        
        viewModel?.productPath.receive(on: RunLoop.main).sink(receiveValue: { [weak self] path in
            self?.pathLabel.text = path
        }).store(in: &cancellables)
        
        viewModel?.productImages.receive(on: RunLoop.main).sink(receiveValue: { [weak self] images in
            self?.carouselView.setImageURLs(images)
        }).store(in: &cancellables)
        
        viewModel?.productPrice.receive(on: RunLoop.main).sink(receiveValue: { [weak self] price in
            self?.priceLabel.text = price
        }).store(in: &cancellables)
        
        viewModel?.productDescription.receive(on: RunLoop.main).sink(receiveValue: {  [weak self] description in
            self?.descriptionLabel.text = description
        }).store(in: &cancellables)
        
        viewModel?.error.receive(on: RunLoop.main).sink(receiveValue: {  [weak self] error in
            self?.presentAlert(error.localizedDescription)
        }).store(in: &cancellables)
    }
    
    // MARK: - Update UI
    
    private func updateView(with product: ProductSearchItem) {
        title = product.title
        titleLabel.text = product.title
        priceLabel.text = String(format: "R$ %.2f", product.price)
    }
}

