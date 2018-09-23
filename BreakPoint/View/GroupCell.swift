//
//  GroupCell.swift
//  BreakPoint
//
//  Created by Mahmoud on 9/16/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var memberCountLbl: UILabel!
    func configureCell(title : String , desc : String , memberCount : Int){
    self.titleLbl.text = title
        self.descLbl.text = desc
        self.memberCountLbl.text = "\(memberCount) members"
    
    }
}
