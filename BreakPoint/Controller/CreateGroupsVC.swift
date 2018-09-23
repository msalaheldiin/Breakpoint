//
//  CreateGroupsVC.swift
//  BreakPoint
//
//  Created by Mahmoud on 9/10/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController {
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupEmailsLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailsTF: InsetTextFiled!
    @IBOutlet weak var descriptionTF: InsetTextFiled!
    @IBOutlet weak var titleTF: InsetTextFiled!
    
    var emailArray = [String]()
    var selectedUserArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailsTF.delegate = self
        emailsTF.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    @objc func textFieldDidChanged() {
        if emailsTF.text == "" {
            emailArray = []
            tableView.reloadData()
        }
        else {
            DataService.instance.getEmail(forSearchQuery: emailsTF.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
        
        
    }
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneWasPressed(_ sender: Any) {
        guard let title = titleTF.text , !title.isEmpty, let description = descriptionTF.text ,
            !description.isEmpty else {return}
        DataService.instance.getIds(forUserNames: selectedUserArray) { (idsArray) in
            var userIds = idsArray
            userIds.append((Auth.auth().currentUser?.uid)!)
            DataService.instance.CreateGroup(withTitle: title, andDescription: description, forUserIds: userIds, handler: { (groupCreated) in
                if groupCreated{
                    self.dismiss(animated: true, completion: nil )
                }
                else {
                    print ("Error While Creating Group")
                }
            })
        
            
        }
        
    }
}
extension CreateGroupsVC: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else { return UITableViewCell ()}
        
        let profileImage = UIImage(named:"defaultProfileImage")
        if selectedUserArray.contains(emailArray[indexPath.row]){
            cell.configureCell(profileimage: profileImage!, email:emailArray[indexPath.row], isSelected: true)
        }
        else {
            cell.configureCell(profileimage: profileImage!, email:emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return}
        if !selectedUserArray.contains(cell.emailLbl.text!){
            selectedUserArray.append(cell.emailLbl.text!)
            groupEmailsLbl.text = selectedUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }
        else {
            selectedUserArray = selectedUserArray.filter({$0 != cell.emailLbl.text!})
            if selectedUserArray.count >= 1 {
                groupEmailsLbl.text = selectedUserArray.joined(separator: ", ")
            }
            else {
                groupEmailsLbl.text = "Add user to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC : UITextFieldDelegate {
    
    
}
