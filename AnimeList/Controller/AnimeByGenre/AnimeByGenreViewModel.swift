//
//  AnimeByGenreViewModel.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import Foundation

protocol AnimeByGenreDelegate: AnyObject {
    func getAnimeSuccess()
}


class AnimeByGenreViewModel {
    
    var delegate: AnimeByGenreDelegate?
    
    var networkManager = NetworkManager.sharedInstance
    
    var animes: [AnimeModel] = []
    
    var totalPage = 0
    var page = 1
    
    var genre: GenresItemModel
    init(genre: GenresItemModel) {
        self.genre = genre
    }
    
    func fetchAnime() {
        networkManager.request(route: .animeByGenre(id: genre.malID ?? 0, page: page), model: AnimeByGenreModel.self) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if self.page > 1 {
                    self.animes = self.animes + (success.data ?? [])
                } else {
                    self.animes = success.data ?? []
                }
                self.totalPage = success.pagination?.lastVisiblePage ?? 0
                self.delegate?.getAnimeSuccess()
            case .failure:
                self.animes = []
                self.delegate?.getAnimeSuccess()
            }
        }
    }
    
}
