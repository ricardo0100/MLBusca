//
//  ProductDetails.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 24/07/25.
//

struct ProductDetails: Codable {
    let id: String
    let title: String
    let categoryID: String
    let price: Double
    let currencyID: String
    let thumbnail: String
    let pictures: [Picture]
    let variations: [Variation]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case categoryID = "category_id"
        case currencyID = "currency_id"
        case thumbnail
        case pictures
        case variations
    }
}

struct Picture: Codable {
    let id: String
    let url: String
    let secureURL: String
    let size: String
    let maxSize: String
    let quality: String

    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}

struct Variation: Codable {
    let id: Int
    let price: Double
    let pictureIDs: [String]
    let catalogProductID: String?

    enum CodingKeys: String, CodingKey {
        case id, price
        case pictureIDs = "picture_ids"
        case catalogProductID = "catalog_product_id"
    }
}
