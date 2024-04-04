//
//  TopAnimeViewController.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import UIKit

class TopAnimeViewController: UIViewController {
    
    var viewModel: TopAnimeViewModel!
    
    @IBOutlet weak var tableViewTopAnime: UITableView!
    @IBOutlet weak var collectionViewType: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchTopAnime()
    }
    
    func setupViews() {
        tableViewTopAnime.register(UINib(nibName: "TopAnimeCell", bundle: nil), forCellReuseIdentifier: "TopAnimeCell")
        tableViewTopAnime.dataSource = self
        tableViewTopAnime.delegate = self
        viewModel.delegate = self
        
        collectionViewType.register(UINib(nibName: "TopAnimeTypeCell", bundle: nil), forCellWithReuseIdentifier: "TopAnimeTypeCell")
        collectionViewType.delegate = self
        collectionViewType.dataSource = self
        collectionViewType.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    @IBAction func backAction(_ sender: Any) {
        AppRouter.sharedInstance.dismissDetail()
    }
}

extension TopAnimeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topAnime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopAnimeCell", for: indexPath) as? TopAnimeCell else {
            return UITableViewCell()
        }
        cell.setupData(data: viewModel.topAnime[indexPath.row], hiddenDivider: indexPath.row == 0, index: indexPath.row + 1)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard viewModel.page < viewModel.totalPage else { return }
        if indexPath.row > viewModel.topAnime.count - 3 {
            viewModel.page += 1
            viewModel.fetchTopAnime()
        }
    }
}

extension TopAnimeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopAnimeTypeCell", for: indexPath) as? TopAnimeTypeCell else {
            return UICollectionViewCell()
        }
        cell.setupData(type: viewModel.listType[indexPath.row], isSelected: viewModel.currentType == viewModel.listType[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel.listType[indexPath.row].title
        let width = text.trimmingCharacters(in: .whitespaces).width(withConstrainedHeight: 0, font: .systemFont(ofSize: 14))
        return CGSize(width: width + 40, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tableViewTopAnime.isUserInteractionEnabled = false
        collectionViewType.isUserInteractionEnabled = false
        viewModel.page = 1
        viewModel.currentType = viewModel.listType[indexPath.row]
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
}

extension TopAnimeViewController: AnimeItemDelegate {
    func didSelectAnime(_ animeData: AnimeModel) {
        AppRouter.sharedInstance.navigate(to: RouterController.animeDetail(data: animeData), with: .push)
    }
}

extension TopAnimeViewController: TopAnimeDelegate {
    func getTopAnimeSuccess() {
        tableViewTopAnime.isUserInteractionEnabled = true
        collectionViewType.isUserInteractionEnabled = true
        tableViewTopAnime.reloadData()
        tableViewTopAnime.isHidden = viewModel.listType.isEmpty
    }
}
