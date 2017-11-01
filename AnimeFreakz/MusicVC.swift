//
//  MusicVC.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/22/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MusicVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var ref: DatabaseReference = Database.database().reference().child("music")
    private var refHandle: DatabaseHandle?
    
    @IBOutlet weak var tableView : UITableView!

    let cellId = "MusicCell"
    var musics : [Music] = []
    let cellSpacingHeight: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         let nib = UINib(nibName: cellId, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellId)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 180.0
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.musics.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ref.observe(DataEventType.value, with: { (snapshot) in
           //let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.musics = Music.modelsFromDictionaryArray(array: snapshot.value as! NSArray)
            self.tableView.reloadData()
        })
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)! as! MusicCell
        cell.configureWith(musics[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }


}
