//
//  TopAnimeModel.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import Foundation

// MARK: - TopAnimeModel
struct TopAnimeModel: Codable {
    var pagination: Pagination?
    var data: [AnimeModel]?
    
    enum CodingKeys: String, CodingKey {
        case data, pagination
    }
}
