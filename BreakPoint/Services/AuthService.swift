//
//  AuthService.swift
//  BreakPoint
//
//  Created by Mahmoud on 8/30/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    func registerUser(withEmail email:String , andPassword password: String , userCreationComplete: @escaping (_ status: Bool , _ error:Error?)->())  {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false,error)
               return
            }
            let userData = ["provider" : user.user.providerID, "email" : user.user.email]
            DataService.instance.CreateDbUser(uid:user.user.uid , userData: userData)
            userCreationComplete(true, nil)
        }
        }
        
        
    
    
    func loginUser(withEmail email:String , andPassword Password: String , userLoginComplete: @escaping (_ status: Bool , _ error:Error?)->()  )  {
        Auth.auth().signIn(withEmail: email, password: Password) { (user,error) in
           if error != nil {
                userLoginComplete(false , error)
                return
            }
            userLoginComplete(true, nil)
        }
        
    }
}

