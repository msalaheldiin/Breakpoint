//
//  UserCell.swift
//  BreakPoint
//
//  Created by Mahmoud on 9/15/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit
class UserCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    
    var showing = false
    func configureCell(profileimage : UIImage , email : String , isSelected : Bool){
        self.profileImage.image = profileimage
        self.emailLbl.text = email
        if isSelected{
            self.checkImage.isHidden = false
        }
        else {
            self.checkImage.isHidden = false
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
            }
            else {
                checkImage.isHidden = true
                showing = false
            }
        }
    }
    
}
