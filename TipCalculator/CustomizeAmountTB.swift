//
//  CustomizeAmountTB.swift
//  TipCalculator
//
//  Created by Shirly Manor on 9/17/16.
//  Copyright © 2016 manor. All rights reserved.
//

import UIKit

@IBDesignable

class CustomTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 0
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: inset, dy: inset)
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return textRect(forBounds: bounds)
//    }
//    
//    override func awakeFromNib() {
//        self.layer.cornerRadius = 5.0
//    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.backgroundColor = UIColor.red.cgColor
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}

