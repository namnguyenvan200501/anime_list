//
//  TopAnimeViewModel.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import Foundation

enum TopAnimeType: CaseIterable {
    case all
    case movie
    case ova
    case ona
    case special
    case music
    case tvSpecial
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .movie:
            return "Top Movies"
        case .ova:
            return "Top OVAs"
        case .ona:
            return "Top ONAs"
        case .special:
            return "Top Specials"
        case .music:
            return "Top Musics"
        case .tvSpecial:
            return "Top TV Specials"
        }
    }
    
    var key: String {
        switch self {
        case .all:
            return ""
        case .movie:
            return "movie"
        case .ova:
            return "ova"
        case .ona:
            return "ona"
        case .special:
            return "special"
        case .music:
            return "music"
        case .tvSpecial:
            return "tv_special"
        }
    }
}

protocol TopAnimeDelegate: AnyObject {
    func getTopAnimeSuccess()
}

class TopAnimeViewModel {
    var delegate: TopAnimeDelegate?
    var networkManager = NetworkManager.sharedInstance
    
    var topAnime: [AnimeModel] = []
    
    var listType: [TopAnimeType] {
        return TopAnimeType.allCases
    }
    
    var totalPage = 0
    var page = 1
    
    var currentType: TopAnimeType = .all {
        didSet {
            fetchTopAnime()
        }
    }
    
    func fetchTopAnime() {
        networkManager.request(route: .topAnime(type: currentType, page: page), model: TopAnimeModel.self) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if self.page > 1 {
                    self.topAnime = self.topAnime + (success.data ?? [])
                } else {
                    self.topAnime = success.data ?? []
                }
                self.totalPage = success.pagination?.lastVisiblePage ?? 0
                self.delegate?.getTopAnimeSuccess()
            case .failure:
                self.topAnime = []
                self.delegate?.getTopAnimeSuccess()
            }
        }
    }
}
