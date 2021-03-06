//
//  ChatroomVC.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/24/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import UIKit
import Firebase

enum Section: Int {
    case createNewChannelSection = 0
    case currentChannelsSection
}

class ChatroomVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var senderDisplayName: String? // 1
    var newChannelTextField: UITextField? // 2
    private var channels: [Channel] = [] // 3
    private lazy var channelRef: DatabaseReference = Database.database().reference().child("channels")
    private var channelRefHandle: DatabaseHandle?

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        observeChannels()
        
        if Auth.auth().currentUser != nil {
            if (Auth.auth().currentUser?.isAnonymous)! {
                self.senderDisplayName = "Anon"
            }else {
                self.senderDisplayName = Auth.auth().currentUser?.displayName
                
            }
        }else {
            self.senderDisplayName = "Anon"
        }
    }
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func observeChannels() {
        // Use the observe method to listen for new
        // channels being written to the Firebase DB
        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in // 1
            let channelData = snapshot.value as! Dictionary<String, AnyObject> // 2
            let id = snapshot.key
            if let name = channelData["name"] as! String!, name.count > 0 { // 3
                self.channels.append(Channel(id: id, name: name, image: "", description: ""))
                self.tableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentSection: Section = Section(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelsSection:
                return channels.count
            }
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if (indexPath as NSIndexPath).section == Section.currentChannelsSection.rawValue {
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
           
        }
        
        return cell
    }
    
    @IBAction func createChannel(_ sender: AnyObject) {
        if (newChannelTextField?.text != ""){
        if let name = newChannelTextField?.text { // 1
            let newChannelRef = channelRef.childByAutoId() // 2
            let channelItem = [ // 3
                "name": name
            ]
            newChannelRef.setValue(channelItem) // 4
            }}
        else {
            let alert = UIAlertController(title: "Empty Field", message: "Please Enter A Channel Name to Create", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            let chatVc = segue.destination as! ChatViewController
            
            chatVc.senderDisplayName = senderDisplayName
            chatVc.channel = channel
            chatVc.channelRef = channelRef.child(channel.id)
        }
    }
    
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == Section.currentChannelsSection.rawValue {
            let channel = channels[(indexPath as NSIndexPath).row]
            self.performSegue(withIdentifier: "ShowChannel", sender: channel)
        }
    }

}
