//
//  DashboardVC.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/17/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DashboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private lazy var ref: DatabaseReference = Database.database().reference().child("dashboard")
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
      //      let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.dashboard = Dashboard.modelsFromDictionaryArray(array: snapshot.value as! NSArray)
            self.collectionView.reloadData()
        })
        
        if(Auth.auth().currentUser?.displayName == nil && !(Auth.auth().currentUser?.isAnonymous)!){
            //1. Create the alert controller.
            let alert = UIAlertController(title: "Enter Display Name", message: "Enter a display name for the chatroom", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = ""
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                var displayNameStr : String = (textField?.text)!
                if(displayNameStr.characters.count > 16){
                    displayNameStr = (textField?.text?.trunc(length: 16))!
                }
                changeRequest?.displayName = displayNameStr
                changeRequest?.commitChanges { (error) in
                    // ...
                }
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)

        }
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
            self.performSegue (withIdentifier: (selection.name?.lowercased())!, sender: self)}else {
             self.presentingViewController!.dismiss(animated: true, completion: nil)
        }
     
        
        
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
extension String {
    /*
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     - Parameter length: Desired maximum lengths of a string
     - Parameter trailing: A 'String' that will be appended after the truncation.
     
     - Returns: 'String' object.
     */
    func trunc(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
}
