//
//  GroupFeedVC.swift
//  BreakPoint
//
//  Created by Mahmoud on 9/19/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var sendBtnWasPressed: UIButton!
    @IBOutlet weak var messageTF: InsetTextFiled!
    @IBOutlet weak var sendMsgView: UIView!
    @IBOutlet weak var groupTileLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var group : Group?
    var groupMessages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMsgView.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func initData(forGroup group :Group ) {
        self.group = group
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTileLbl.text = group?.groupTitle
        DataService.instance.getEmailfor(group: group!) { (returnedEmailArray) in
        self.membersLbl.text = returnedEmailArray.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                if self.groupMessages.count > 0{
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count-1, section: 0), at: .none, animated: true)
                }
            })
        }
        
    }
 
    @IBAction func sendBrnWasPressed(_ sender: Any) {
        if messageTF.text != "" {
            messageTF.isEnabled = true
            sendBtnWasPressed.isEnabled = true
            DataService.instance.uploadPost(withMessage: messageTF.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key, sendComplete: { (success) in
                if success {
                    self.messageTF.text = ""
                    self.messageTF.isEnabled = true
                    self.sendBtnWasPressed.isEnabled = true
                }
                
                
            })
        }
        
     
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension GroupFeedVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedcell", for: indexPath) as? groupFeedCell else {
            return UITableViewCell()
        }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUserName(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage: UIImage(named:"defaultProfileImage")!, email: email, content: message.content)
        }
        
        
        
        return cell
    }
}


