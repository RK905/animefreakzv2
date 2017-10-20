//
//  DashBoardCell.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/18/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit

class DashBoardCell: UICollectionViewCell {
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWith(_ model: Dashboard) {
        self.imageView.image = UIImage(named:(model.name?.lowercased())!)
        self.labelView.text = model.name
    }
}
