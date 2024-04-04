//
//  GenresModel.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import Foundation

// MARK: - GenresModel
struct GenresModel: Codable {
    var data: [GenresItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}


// MARK: - GenresItemModel
struct GenresItemModel: Codable {
    var malID: Int?
    var name: String?
    var url: String?
    var count: Int?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case name, url, count
    }
}
