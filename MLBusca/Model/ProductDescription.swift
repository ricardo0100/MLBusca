//
//  ProductDescription.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 24/07/25.
//

struct ProductDescription: Codable {
    let text: String
    let plainText: String
    let lastUpdated: String
    let dateCreated: String
    let snapshot: Snapshot

    enum CodingKeys: String, CodingKey {
        case text
        case plainText = "plain_text"
        case lastUpdated = "last_updated"
        case dateCreated = "date_created"
        case snapshot
    }
}
