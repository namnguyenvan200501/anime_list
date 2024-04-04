//
//  NetworkRouter.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import Foundation

enum NetworkRouter {
    case topAnime(type: TopAnimeType, page: Int)
    case genres
    case animeByGenre(id: Int, page: Int)
}


extension NetworkRouter {
    
    var path: String {
        switch self {
        case .topAnime:
            return "/top/anime"
        case .genres:
            return "/genres/anime"
        case .animeByGenre:
            return "/anime"
        }
    }
    
    var method: URLRequest.HTTPMethod {
        switch self {
        case .topAnime, .genres, .animeByGenre:
            return .get
        }
    }
    
    var query: [String: Any] {
        switch self {
        case let .topAnime(type, page):
            return ["type": type.key, "page": page]
        case .genres:
            return ["filter": "genres"]
        case let .animeByGenre(id, page):
            return ["genres": id, "page": page]
        }
    }
    
    func asURLRequest() -> URLRequest {
        var components = URLComponents(url: BASE_URL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = query.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        return request
    }
}
