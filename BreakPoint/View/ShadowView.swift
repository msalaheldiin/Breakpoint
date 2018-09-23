//
//  ShadowView.swift
//  BreakPoint
//
//  Created by Mahmoud on 8/30/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }

}
