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
    let attributeTypes: String
    let metaCategID: String?
    let attributable: Bool
    let dateCreated: String
    let pathFromRoot: [PathItem]
}
