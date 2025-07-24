//
//  Product.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 21/07/25.
//

import Foundation

struct ProductSearchItem: Codable {
    let id: String
    let title: String
    let thumbnail: String
    let currencyID: String
    let price: Double

    enum CodingKeys: String, CodingKey {
        case id, title
        case thumbnail
        case currencyID = "currency_id"
        case price
    }
}
