//
//  GenresViewController.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import UIKit

class GenresViewController: UIViewController {

    var viewModel: GenresViewModel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchGenres()
    }
    
    func setup() {
        viewModel.delegate = self
        collectionView.register(UINib(nibName: "GenresItemCell", bundle: nil), forCellWithReuseIdentifier: "GenresItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 12, right: 0)
    }
    @IBAction func backAction(_ sender: Any) {
        AppRouter.sharedInstance.dismissDetail()
    }
}

extension GenresViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresItemCell", for: indexPath) as? GenresItemCell else {
            return UICollectionViewCell()
        }
        cell.setupData(data: viewModel.genres[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2
        return CGSize(width: width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppRouter.sharedInstance.navigate(to: RouterController.animeByGenre(genre: viewModel.genres[indexPath.row]), with: .push)
    }
}

extension GenresViewController: GenresDelegate {
    func getGenresSuccess() {
        collectionView.reloadData()
    }
}
