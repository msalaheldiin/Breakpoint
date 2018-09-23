//
//  LoginVC.swift
//  BreakPoint
//
//  Created by Mahmoud on 8/30/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTF: InsetTextFiled!
    @IBOutlet weak var passwordTF: InsetTextFiled!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        passwordTF.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func signInWasPressed(_ sender: Any) {
        guard let email = emailTF.text , !email.isEmpty  else {return }
        guard let password = passwordTF.text , !password.isEmpty  else {return }
      
        AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, loginError) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
            else {print(String(describing:loginError?.localizedDescription))}
        }
        
        AuthService.instance.registerUser(withEmail: email, andPassword: password) { (success, registerError) in
            if success{
                AuthService.instance.loginUser(withEmail: email, andPassword: password, userLoginComplete: { (success, nil) in
                    self.dismiss(animated: true, completion: nil)
                    print("Successfully registered")
                })
            }
            else {
                print(String(describing:registerError?.localizedDescription))
            }
        }
        
    }
    
    @IBAction func cancelWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginVC : UITextFieldDelegate {
    
    
    
}
