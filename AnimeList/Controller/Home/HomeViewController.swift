//
//  HomeViewController.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func topAnimeAction(_ sender: Any) {
        AppRouter.sharedInstance.navigate(to: RouterController.topAnime, with: .push)
    }
    
    
    @IBAction func genresAction(_ sender: Any) {
        AppRouter.sharedInstance.navigate(to: RouterController.genres, with: .push)
    }
    
}
