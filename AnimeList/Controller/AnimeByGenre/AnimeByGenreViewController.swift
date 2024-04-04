//
//  AnimeByGenreViewController.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import UIKit

class AnimeByGenreViewController: UIViewController {

    var viewModel: AnimeByGenreViewModel!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        viewModel.fetchAnime()
        viewModel.delegate = self
        tableView.register(UINib(nibName: "AnimeByGenreItemCell", bundle: nil), forCellReuseIdentifier: "AnimeByGenreItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        lbTitle.text = viewModel.genre.name ?? ""
    }
    
    @IBAction func backAction(_ sender: Any) {
        AppRouter.sharedInstance.dismissDetail()
    }
}

extension AnimeByGenreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeByGenreItemCell", for: indexPath) as? AnimeByGenreItemCell else {
            return UITableViewCell()
        }
        cell.setupData(data: viewModel.animes[indexPath.row], hiddenDivider: indexPath.row == 0)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard viewModel.page < viewModel.totalPage else { return }
        if indexPath.row > viewModel.animes.count - 3 {
            viewModel.page += 1
            viewModel.fetchAnime()
        }
    }
}

extension AnimeByGenreViewController: AnimeItemDelegate {
    func didSelectAnime(_ animeData: AnimeModel) {
        AppRouter.sharedInstance.navigate(to: RouterController.animeDetail(data: animeData), with: .push)
    }
}

extension AnimeByGenreViewController: AnimeByGenreDelegate {
    func getAnimeSuccess() {
        tableView.reloadData()
    }
}
