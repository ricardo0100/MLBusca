//
//  SearchResponse.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 21/07/25.
//

import Foundation

struct SearchResponse: Codable {
    let siteID: String
    let countryDefaultTimeZone: String
    let query: String
    let paging: Paging
    let results: [Product]

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case countryDefaultTimeZone = "country_default_time_zone"
        case query, paging, results
    }
}
