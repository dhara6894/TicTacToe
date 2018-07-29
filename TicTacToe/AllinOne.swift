//
//  AllinOne.swift
//  CustomTextfield
//
//  Created by Dhara Patel on 28/07/18.
//  Copyright © 2018 Dhara Patel. All rights reserved.
//

import UIKit

@IBDesignable class AllinOne: UITextField {
    //to add space at right side while adding rightviewmode
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    //to add space at left side while adding leftviewmode
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var cornerRadious: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadious
            clipsToBounds = true
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var placeHolderColor: UIColor = .clear {
        didSet{
            attributedPlaceholder = NSAttributedString(string: self.placeholder == nil ? "" : self.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: placeHolderColor,NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)])
        }
    }
    @IBInspectable var bottomBorder:Bool = false{
        didSet{
            if bottomBorder{
                
            self.borderStyle = .none
            self.layer.backgroundColor = UIColor.white.cgColor
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0.0
            }else{
                return
            }
        }
    }
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var leftViewImage: UIImage? {
       didSet{
        if let image = leftViewImage{
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .lightGray
            leftView = imageView
        }else{
            leftViewMode = .never
        }
     }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0
    @IBInspectable var rightViewImage: UIImage? {
        didSet{
            if let image = rightViewImage{
                rightViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: frame.size.width - 20, y: 0, width: 20, height: 20))
                imageView.image = image.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = .blue
                
                rightView = imageView
            }else{
                rightViewMode = .never
            }
        }
    }
}
