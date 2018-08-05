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
    class func likeAnimation(imgView: UIImageView) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
            imgView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            imgView.alpha = 1.0
        }, completion: { (finished) in
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
                imgView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
    }
    
    class func addLine(from startPoint: CGPoint, to endPoint: CGPoint, view:UIView,duration: CFloat,strokeColor: UIColor,width: CFloat = 10, delay: Double){
        // create path
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            
        // Create a `CAShapeLayer` that uses that `UIBezierPath`:
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = CGFloat(width)
        shapeLayer.lineJoin = kCALineJoinBevel
        Helper.addShadow(to: shapeLayer, with: 3.0)
        
        // Add that `CAShapeLayer` to your view's layer:
        view.layer.addSublayer(shapeLayer)
        
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = CFTimeInterval(duration)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        shapeLayer.add(pathAnimation, forKey: "strokeEnd")
        })
        }

}
