//
//  groupFeedCell.swift
//  BreakPoint
//
//  Created by Mahmoud on 9/19/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class groupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(profileImage : UIImage , email:String , content : String){
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = content
    
    
    }
}
