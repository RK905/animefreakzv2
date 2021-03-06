//
//  NewsVC.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/20/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import KRProgressHUD
import FirebaseDatabase

class NewsVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    private lazy var ref: DatabaseReference = Database.database().reference().child("news")
    private var refHandle: DatabaseHandle?
    
    var models:[NewsModel] = []
    let cellId = "NewsCell"
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: nil)
        collectionView.register( nib, forCellWithReuseIdentifier: cellId)

        
        //                    UINavigationBar.appearance().setBackgroundImage(UIImage(named: "banner")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //self.getJsonFromUrl()
        
            ref.observe(DataEventType.value, with: { (snapshot) in
                //let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                self.models = NewsModel.modelsFromDictionaryArray(array: snapshot.value as! NSArray)
                self.collectionView.reloadData()
            })
  
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
        cell.configureWith(models[indexPath.row])
        return cell
    }
    
    func getJsonFromUrl(){
        KRProgressHUD.show(withMessage: "Loading...")
        //creating a NSURL
        let url = URL(string: Constants.homeNewsApi)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {
                self.models = NewsModel.modelsFromDictionaryArray(array: jsonObj!)
                DispatchQueue.main.async(execute: {self.collectionView.reloadData()})
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    KRProgressHUD.dismiss()
                }
            }
            
        }).resume()
    }
    
    
    
}

