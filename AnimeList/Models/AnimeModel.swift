//
//  AnimeModel.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import Foundation


// MARK: - AnimeModel
struct AnimeModel: Codable {
    var malID: Int?
    var url: String?
    var images: AnimeImageModel?
    var trailer: Trailer?
    var approved: Bool?
    var title, titleEnglish, titleJapanese: String?
    var type, source: String?
    var episodes: Int?
    var status: String?
    var airing: Bool?
    var aired: Aired?
    var duration, rating: String?
    var score: Double?
    var synopsis, background, season: String?
    var studios, genres, producers, demographics: [Demographic]?
    var rank: Int?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, trailer, approved, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case synopsis, background, season, studios, genres, demographics, rank, producers
    }
}

// MARK: - AnimeImageModel
struct AnimeImageModel: Codable {
    var jpg: Image?
    var webp: Image?
    
    enum CodingKeys: String, CodingKey {
        case jpg, webp
    }
}

// MARK: - Image
struct Image: Codable {
    var imageURL, smallImageURL, largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Trailer
struct Trailer: Codable {
    var youtubeID: String?
    var url, embedURL: String?
    var images: TrailerImages?

    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
        case embedURL = "embed_url"
        case images
    }
}

// MARK: - TrailerImages
struct TrailerImages: Codable {
    var imageURL, smallImageURL, mediumImageURL, largeImageURL: String?
    var maximumImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
        case maximumImageURL = "maximum_image_url"
    }
}

// MARK: - Aired
struct Aired: Codable {
    var from, to: String?
    var string: String?
}

// MARK: - Demographic
struct Demographic: Codable {
    var malID: Int?
    var type: String?
    var name: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    var lastVisiblePage: Int?

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
    }
}
