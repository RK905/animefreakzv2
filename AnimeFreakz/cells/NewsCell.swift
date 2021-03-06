//
//  NewsCell.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/21/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homeBody: UILabel!
    @IBOutlet weak var homeTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.masksToBounds = false
    }
    
    
    func configureWith(_ model: NewsModel) {
        if let url = URL(string: model.article_img!){
            self.homeImg.kf.setImage(with: url)}
        self.homeTitle.text = model.title
        self.homeBody.text = model.body
    }
}
