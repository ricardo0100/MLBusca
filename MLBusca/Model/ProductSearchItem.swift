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
    let condition: String
    let thumbnailID: String?
    let catalogProductID: String?
    let listingTypeID: String
    let permalink: String
    let buyingMode: String
    let siteID: String
    let categoryID: String
    let domainID: String
    let thumbnail: String
    let currencyID: String
    let orderBackend: Int
    let price: Double
    let originalPrice: Double?
    let availableQuantity: Int
    let officialStoreID: Int?
    let officialStoreName: String?
    let acceptsMercadoPago: Bool
    let stopTime: String
    let catalogListing: Bool
    let inventoryID: String?
    let resultType: String

    enum CodingKeys: String, CodingKey {
        case id, title, condition
        case thumbnailID = "thumbnail_id"
        case catalogProductID = "catalog_product_id"
        case listingTypeID = "listing_type_id"
        case permalink
        case buyingMode = "buying_mode"
        case siteID = "site_id"
        case categoryID = "category_id"
        case domainID = "domain_id"
        case thumbnail
        case currencyID = "currency_id"
        case orderBackend = "order_backend"
        case price
        case originalPrice = "original_price"
        case availableQuantity = "available_quantity"
        case officialStoreID = "official_store_id"
        case officialStoreName = "official_store_name"
        case acceptsMercadoPago = "accepts_mercadopago"
        case stopTime = "stop_time"
        case catalogListing = "catalog_listing"
        case inventoryID = "inventory_id"
        case resultType = "result_type"
    }
}

