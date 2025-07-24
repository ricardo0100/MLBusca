//
//  ImageCarouselView.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 24/07/25.
//

import UIKit

final class ImageCarouselView: UIView {

    private var imageURLs: [URL] = []

    // MARK: - Subviews

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: bounds.width, height: bounds.height)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.reuseID)
        collection.dataSource = self
        return collection
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Public

    func setImageURLs(_ urls: [URL]) {
        self.imageURLs = urls
        collectionView.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ImageCarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCarouselCell.reuseID,
            for: indexPath
        ) as? ImageCarouselCell else {
            return UICollectionViewCell()
        }

        cell.setImage(from: imageURLs[indexPath.item])
        return cell
    }
}
