//
//  Paging.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 21/07/25.
//
import Foundation

struct Paging: Codable {
    let total, primaryResults, offset, limit: Int

    enum CodingKeys: String, CodingKey {
        case total
        case primaryResults = "primary_results"
        case offset, limit
    }
}
