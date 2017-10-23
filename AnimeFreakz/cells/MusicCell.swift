//
//  MusicCell.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/22/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import Kingfisher

class MusicCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.masksToBounds = false
    }
    
    

    var swiftyRadio: SwiftyRadio = SwiftyRadio()
    @IBOutlet weak var imageBox: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ model: Music) {
        self.name.text = model.name
        if let url = URL(string: model.image!){
            self.imageBox.kf.setImage(with: url)
        }
        self.swiftyRadio.setup()
        self.swiftyRadio.setStation(name: model.name!, URL: model.url!)
        
    }
    
    @IBAction func pressPlay(_ sender: Any) {
        swiftyRadio.play()
    }
    @IBAction func pressStop(_ sender: Any) {
        swiftyRadio.stop()
    }
}
