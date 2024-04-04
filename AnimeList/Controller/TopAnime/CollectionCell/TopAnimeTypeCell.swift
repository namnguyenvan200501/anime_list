//
//  TopAnimeTypeCell.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import UIKit

class TopAnimeTypeCell: UICollectionViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lbType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(type: TopAnimeType, isSelected: Bool) {
        viewBg.backgroundColor = isSelected ? .orange : .clear
        viewBg.layer.borderWidth = isSelected ? 0 : 1
        lbType.text = type.title
    }
    
}
