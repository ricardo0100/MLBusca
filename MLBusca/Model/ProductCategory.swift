//
//  ProductCategory.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 24/07/25.
//

struct ProductCategory: Codable {
    let id: String
    let name: String
    let picture: String?
    let permalink: String?
    let totalItemsInThisCategory: Int
    let pathFromRoot: [PathItem]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case picture
        case permalink
        case totalItemsInThisCategory = "total_items_in_this_category"
        case pathFromRoot = "path_from_root"
    }
}

struct PathItem: Codable {
    let id: String
    let name: String
}
