//
//  ProfileVC.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 11/1/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class ProfileVC : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            if (Auth.auth().currentUser?.isAnonymous)! {
                let alertController = UIAlertController(title: "No Profile", message: "You will be sent back to dashboard. Please login with credentials to view profile page", preferredStyle: .alert)
                
                let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
               _ = self.navigationController?.popViewController(animated: true)
                }
                
                alertController.addAction(action1)
                self.present(alertController, animated: true, completion: nil)
            }
            
        } else {
            // No user is signed in.
            // ...
        }
    }
    
}
