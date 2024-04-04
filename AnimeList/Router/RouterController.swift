//
//  RouterController.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import Foundation
import UIKit

enum RouterController: Route {
    case home
    case topAnime
    case animeDetail(data: AnimeModel)
    case genres
    case animeByGenre(genre: GenresItemModel)
    
    var screen: UIViewController {
        switch self {
        case .home:
            let home = HomeViewController()
            home.viewModel = HomeViewModel()
            return home
        case .topAnime:
            let topAnime = TopAnimeViewController()
            topAnime.viewModel = TopAnimeViewModel()
            return topAnime
        case let .animeDetail(data):
            let animeDetail = AnimeDetailViewController()
            animeDetail.viewModel = AnimeDetailViewModel(data: data)
            return animeDetail
        case .genres:
            let genres = GenresViewController()
            genres.viewModel = GenresViewModel()
            return genres
        case let .animeByGenre(genre):
            let animeByGenre = AnimeByGenreViewController()
            animeByGenre.viewModel = AnimeByGenreViewModel(genre: genre)
            return animeByGenre
        }
    }
}

