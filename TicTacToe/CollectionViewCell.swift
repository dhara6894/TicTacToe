//
//  CollectionViewCell.swift
//  TicTacToe
//
//  Created by dhara.patel on 06/03/17.
//  Copyright © 2017 SASA. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var IBimgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        IBimgView.backgroundColor = UIColor.white
        IBimgView.image = UIImage(named: "img_Blank")
        // Initialization code
    }

}
