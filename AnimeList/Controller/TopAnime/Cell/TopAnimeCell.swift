//
//  TopAnimeCell.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import UIKit

protocol AnimeItemDelegate: AnyObject {
    func didSelectAnime(_ animeData: AnimeModel)
}

class TopAnimeCell: UITableViewCell {

    @IBOutlet weak var viewDivider: UIView!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbEposide: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbAired: UILabel!
    
    private var imageLoader: ImageLoader?
    
    var delegate: AnimeItemDelegate?
    
    var animeData: AnimeModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animeTapped)))
    }
    
    func setupData(data: AnimeModel, hiddenDivider: Bool, index: Int) {
        viewDivider.isHidden = hiddenDivider
        animeData = data
        lbRank.text = "\(index)"
        lbTitle.text = data.title ?? ""
        lbEposide.text = "\(data.type ?? "") (\(data.episodes ?? 0) eps)"
        lbScore.text = "Score: \(data.score ?? 0)"
        lbAired.text = data.aired?.string ?? ""
        
        if let jpgImages = data.images?.jpg?.imageURL {
            imageLoader = ImageLoader()
            imageLoader?.loadImage(from: jpgImages) {[weak self] image in
                DispatchQueue.main.async {
                    self?.imgThumb.image = image
                }
            }
        }
    }
    
    @objc private func animeTapped() {
        guard let animeData = animeData else { return }
        delegate?.didSelectAnime(animeData)
    }
}
