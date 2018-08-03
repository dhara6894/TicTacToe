//
//  BezierPath.swift
//  TicTacToe
//
//  Created by Dhara Patel on 02/08/18.
//  Copyright © 2018 SASA. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{
    
    func makeStartEndPoint(on indexpath: IndexPath) -> CGRect{
        let attributes: UICollectionViewLayoutAttributes? = self.layoutAttributesForItem(at: indexpath)
        let cellRect: CGRect? = attributes?.frame
        let cellFrameInSuperview = self.convert(cellRect ?? CGRect.zero, to: self.superview)
        return cellFrameInSuperview
        
    }
}
