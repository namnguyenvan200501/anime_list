//
//  GenresItemCell.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import UIKit

class GenresItemCell: UICollectionViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(data: GenresItemModel) {
        lbName.text = data.name ?? ""
        lbCount.text = "(\(data.count ?? 0))"
    }
    
}
