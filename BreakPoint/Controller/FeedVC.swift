//
//  FirstViewController.swift
//  BreakPoint
//
//  Created by Mahmoud on 8/29/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    var messageArray = [Message]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }
  

   
}

extension FeedVC: UITableViewDelegate , UITableViewDataSource {
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FeedCell else {return UITableViewCell()}
        let image = UIImage(named:"defaultProfileImage")
        let message = messageArray[indexPath.row]
        DataService.instance.getUserName(forUID: message.senderId) { (returnedUserName) in
            cell.congigureCell(profileImage: image!, email: returnedUserName, conttent: message.content)
        }
        
        
        return cell
    }
}

