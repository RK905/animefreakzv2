//
//  QuotesVC.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/21/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import FirebaseDatabase

class QuotesVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate  {
    private lazy var ref: DatabaseReference = Database.database().reference().child("quotes")
    private var refHandle: DatabaseHandle?
    @IBOutlet weak var collectionView : UICollectionView!
    let cellId = "QuoteCell"
    var quotes : [Quotes] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: cellId, bundle: nil)
        collectionView.register( nib, forCellWithReuseIdentifier: cellId)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ref.observe(DataEventType.value, with: { (snapshot) in
            //let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.quotes = Quotes.modelsFromDictionaryArray(array: snapshot.value as! NSArray)
            self.collectionView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.quotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! QuoteCell
        cell.configureWith(quotes[indexPath.row])
        return cell
    }


}
