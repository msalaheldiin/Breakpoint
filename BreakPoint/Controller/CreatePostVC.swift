//
//  CreatePostVC.swift
//  BreakPoint
//
//  Created by Mahmoud on 9/1/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var postTV: UITextView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        postTV.delegate = self
        sendBtn.bindToKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendWasPressed(_ sender: Any) {
        if postTV.text != nil && postTV.text != "Say Somthing Here..."{
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: postTV.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    self.sendBtn.isEnabled = true
                    print("Error...")
                }
            })
            
        }
    }
    
}
extension CreatePostVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        postTV.text = ""
    }
}







