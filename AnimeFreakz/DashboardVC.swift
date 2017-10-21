//
//  DashboardVC.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/17/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DashboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private lazy var ref: DatabaseReference = Database.database().reference()
    private var refHandle: DatabaseHandle?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dashboard : [Dashboard] = []
    let cellId = "dashboardCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellId, bundle: nil)
        self.collectionView.register( nib, forCellWithReuseIdentifier: cellId)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.orange]

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
        ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.dashboard = Dashboard.modelsFromDictionaryArray(array: postDict["dashboard"] as! NSArray)
            self.collectionView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DashBoardCell
            cell.configureWith(self.dashboard[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selection = self.dashboard[indexPath.row]
        if canPerformSegue(id: (selection.name?.lowercased())!){
            self.performSegue (withIdentifier: (selection.name?.lowercased())!, sender: self)}
     
        
        
    }
    
}

extension UIViewController {
    func canPerformSegue(id: String) -> Bool {
        let segues = self.value(forKey: "storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == id })
        return (filtered!.count > 0)
    }
    
    // Just so you dont have to check all the time
    func performSegue(id: String, sender: AnyObject?) -> Bool {
        if canPerformSegue(id: id) {
            self.performSegue(withIdentifier: id, sender: sender)
            return true
        }
        return false
    }
}

