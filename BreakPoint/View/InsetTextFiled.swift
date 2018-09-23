//
//  InsetTextFiled.swift
//  BreakPoint
//
//  Created by Mahmoud on 8/30/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class InsetTextFiled: UITextField {
    
    private var textRectOffset : CGFloat = 20
    override func awakeFromNib() {
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor :#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        )
        self.attributedPlaceholder = placeholder
        super.awakeFromNib()
    }
    private var padding = UIEdgeInsetsMake(0, 20, 0, 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
    
}
