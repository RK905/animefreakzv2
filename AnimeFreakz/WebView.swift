//
//  WebView.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 11/2/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit

class WebView: UIViewController {

    @IBOutlet weak var forumWeb: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.forumWeb.loadRequest(URLRequest(url: URL(string: "http://animefreakz.net")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
