//
//  WeeklysVC.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 11/8/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import KRProgressHUD


class WeeklysVC: UITableViewController {
var tableArray = [Items] ()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let nib = UINib(nibName: "weeklyCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "weeklyCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getJsonFromUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyCell", for: indexPath) as! weeklyCell
        
        
        cell.titleLabel.text = self.tableArray[indexPath.row].name
        
        return cell
    }

   
    func getJsonFromUrl(){
        KRProgressHUD.show(withMessage: "Loading...")
        //creating a NSURL
        let url = URL(string: Constants.weeklysApi)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                self.tableArray  = Items.modelsFromDictionaryArray(array: jsonObj!["items"] as! NSArray)
               
                DispatchQueue.main.async(execute: {self.tableView.reloadData()})
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    KRProgressHUD.dismiss()
                }
            }
            
        }).resume()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if let url = URL(string: self.tableArray[indexPath.row].itemLink!) {
            do {
                let contents = try String(contentsOf: url)
                let linkRegexPattern = "\"(.*?)https?.*?\\.mp4.*?\"(.*?)"
                let matched = matches(for: linkRegexPattern, in: contents)
                let videoLink = matched[0] as String
                let parsedLink = videoLink.slice(from: "\"", to: "\"")
                let urlwithPercentEscapes = parsedLink?.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                if let url = URL(string: urlwithPercentEscapes!) {
                    UIApplication.shared.open(url, options: [:])
                }
                
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
    }
    

    
    func matches(for regex: String, in text: String) -> [String] {
     
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
