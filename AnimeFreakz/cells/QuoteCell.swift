//
//  QuoteCell.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/21/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit

class QuoteCell: UICollectionViewCell {

    @IBOutlet weak var quoteLabel : UILabel!
    @IBOutlet weak var nameLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.masksToBounds = false
    }
    
    
    func configureWith(_ model: Quotes) {
        self.quoteLabel.text = model.quote
        self.nameLabel.text = model.name
    }

}
