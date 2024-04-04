//
//  GenresViewModel.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import Foundation

protocol GenresDelegate: AnyObject {
    func getGenresSuccess()
}

class GenresViewModel {
    var networkManager = NetworkManager.sharedInstance
    
    var delegate: GenresDelegate?
    
    var genres: [GenresItemModel] = []
    
    func fetchGenres() {
        networkManager.request(route: .genres, model: GenresModel.self) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.genres = success.data ?? []
                self.delegate?.getGenresSuccess()
            case .failure(let failure):
                self.genres = []
                self.delegate?.getGenresSuccess()
            }
        }
    }
}
