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
        IBimgView.contentMode = .scaleAspectFit
        IBimgView.backgroundColor = UIColor.white
    }
    func configureCell(_ isEven: Bool){
        if isEven{
            IBimgView.image = #imageLiteral(resourceName: "hate")
        }else{
            IBimgView.image = #imageLiteral(resourceName: "love")
        }
        Helper.likeAnimation(imgView: IBimgView)
    }
}
