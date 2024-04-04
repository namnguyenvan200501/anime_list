//
//  AnimeByGenreItemCell.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import UIKit

class AnimeByGenreItemCell: UITableViewCell {

    @IBOutlet weak var viewDivider: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEpisodes: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbAired: UILabel!
    
    private var imageLoader: ImageLoader?
    
    var delegate: AnimeItemDelegate?
    
    var animeData: AnimeModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animeTapped)))
    }
    
    func setupData(data: AnimeModel, hiddenDivider: Bool) {
        viewDivider.isHidden = hiddenDivider
        animeData = data
        lbName.text = data.title ?? ""
        lbEpisodes.text = "\(data.type ?? "") (\(data.episodes ?? 0) eps)"
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
