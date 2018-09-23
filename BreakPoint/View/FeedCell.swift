//
//  FeddCellTableViewCell.swift
//  BreakPoint
//
//  Created by Mahmoud on 9/9/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    func congigureCell(profileImage:UIImage , email:String , conttent: String)  {
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.contentLbl.text = conttent
    }
}
