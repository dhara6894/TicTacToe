//
//  Helper.swift
//  TicTacToe
//
//  Created by Dhara Patel on 03/08/18.
//  Copyright © 2018 SASA. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
     class func addShadow(to layer: CALayer, with raious : CGFloat){
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 3.0
        layer.shadowRadius = raious
    }
    
    class func addAnimationToImgView(img: UIImage,imgView: UIImageView){
        UIView.transition(with: imgView, duration: 0.5, options: .transitionCrossDissolve, animations: {
//            self.addShadow(to: imgView.layer, with: 1.0)
            imgView.image = img
        }, completion: nil)
    }
    class func addLine(from startPoint: CGPoint, to endPoint: CGPoint, view:UIView,duration: CFloat,strokeColor: UIColor){
        // create path
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        // Create a `CAShapeLayer` that uses that `UIBezierPath`:
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.lineJoin = kCALineJoinBevel
        Helper.addShadow(to: shapeLayer, with: 3.0)
        
        // Add that `CAShapeLayer` to your view's layer:
        view.layer.addSublayer(shapeLayer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = CFTimeInterval(duration)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        shapeLayer.add(pathAnimation, forKey: "strokeEnd")
    }

}
