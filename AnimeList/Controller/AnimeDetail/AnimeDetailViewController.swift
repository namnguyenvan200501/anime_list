//
//  AnimeDetailViewController.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import UIKit

class AnimeDetailViewController: UIViewController {

    private var imageLoader = ImageLoader()
    var viewModel: AnimeDetailViewModel!
    
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbRank: UILabel!
    
    @IBOutlet weak var lbSynopsis: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbEpisode: UILabel!
    @IBOutlet weak var lbAired: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbStudio: UILabel!
    @IBOutlet weak var lbProducer: UILabel!
    @IBOutlet weak var lbDemographic: UILabel!
    
    @IBOutlet weak var btnWatchTrailer: UIButton!
    
    var trailerUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData(data: viewModel.data)
        
    }

    func setupData(data: AnimeModel) {
        imageLoader.loadImage(from: data.images?.jpg?.imageURL ?? "") {[weak self] image in
            DispatchQueue.main.async {
                self?.imgThumb.image = image
            }
        }
        lbName.text = data.title
        lbScore.text = "\(data.score ?? 0)"
        lbRank.text = "\(data.rank ?? 0)"
        lbSynopsis.text = data.synopsis ?? ""
        lbType.text = data.type ?? ""
        lbEpisode.text = "\(data.episodes ?? 0)"
        lbAired.text = data.aired?.string ?? ""
        lbGenre.text = data.genres?.map({$0.name ?? ""}).joined(separator: ", ") ?? ""
        lbStudio.text = data.studios?.map({$0.name ?? ""}).joined(separator: ", ") ?? ""
        lbProducer.text = data.producers?.map({$0.name ?? ""}).joined(separator: ", ") ?? ""
        lbDemographic.text = data.demographics?.map({$0.name ?? ""}).joined(separator: ", ") ?? ""
        
        if let url = data.trailer?.url {
            btnWatchTrailer.isHidden = false
            trailerUrl = url
        } else {
            btnWatchTrailer.isHidden = true
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        AppRouter.sharedInstance.dismissDetail()
    }
    
    @IBAction func watchTrailerAction(_ sender: Any) {
        if let url = URL(string: trailerUrl), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
