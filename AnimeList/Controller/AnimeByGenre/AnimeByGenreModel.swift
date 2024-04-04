//
//  AnimeByGenreModel.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import Foundation

// MARK: - AnimeByGenreModel
struct AnimeByGenreModel: Codable {
    var pagination: Pagination?
    var data: [AnimeModel]?
    
    enum CodingKeys: String, CodingKey {
        case data, pagination
    }
}
