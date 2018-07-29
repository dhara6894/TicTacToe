//
//  ZeroxCollectionViewController.swift
//  TicTacToe
//
//  Created by dhara.patel on 06/03/17.
//  Copyright © 2017 SASA. All rights reserved.
//

import UIKit

class ZeroxCollectionViewController: UIViewController {

    var count = 0
    var playerOneName = String()
    var playerTwoName = String()
    var arrCross = [Int]()
    var arrZero =  [Int]()
    let arrPosibileValue = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    @IBOutlet weak var zeroXCollectionView: UICollectionView!
    @IBOutlet weak var IBlblDesision: UILabel!
    @IBOutlet weak var IBlblPlayerOne: UILabel!
    @IBOutlet weak var IBlblPlayerTwo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        zeroXCollectionView.delegate = self
        zeroXCollectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        zeroXCollectionView.allowsMultipleSelection = true
        zeroXCollectionView.register(UINib(nibName: "CollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        IBlblDesision.isHidden = true
        IBlblPlayerOne.text = playerOneName
        IBlblPlayerTwo.text = playerTwoName
    }
}
extension ZeroxCollectionViewController:  UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(2))
        let size = Int((zeroXCollectionView.bounds.size.width - totalSpace) / CGFloat(3))
        return CGSize(width: size, height: size)
        
    }
}
extension ZeroxCollectionViewController{
    
    func checkCrossValue(){
        for i in arrPosibileValue{
            let sPosibilitiesList = Set(i)                                   //arrayValue
            var sCrossOrZeroLost = Set<Int>()                                //crossValue or zeroValue
            var message = String()
            if count % 2 == 0{                                       //check for cross or zero
                sCrossOrZeroLost = Set(arrZero)
                message = "Unfortunately \(playerTwoName) Won.. Well played \(playerOneName)"
            }else{
                sCrossOrZeroLost = Set(arrCross)
                message = "\(playerOneName) Won"
            }
            //check arrayValue elements contain in cross array or zero array
            if sPosibilitiesList.isSubset(of: sCrossOrZeroLost){
                for j in i{                                      //if match with posibilities than color it
                    let indexPath = IndexPath(item: j, section: 0)
                    let cell =  zeroXCollectionView.cellForItem(at: indexPath as IndexPath)
                    cell?.backgroundColor = UIColor.green
                    zeroXCollectionView.deselectItem(at: indexPath, animated: false)
                }
                IBlblDesision.isHidden = false
                IBlblDesision.text = message
                zeroXCollectionView.allowsSelection = false
            }else{
                if count == 9{
                    IBlblDesision.isHidden = false
                    IBlblDesision.text = "Tie"
                }
            }
        }
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPlayAgain(_ sender: UIButton) {
        arrCross.removeAll()
        arrZero.removeAll()
        IBlblDesision.isHidden = true
        count = 0
        for i in 0..<9 {
            let indexPath = IndexPath(item: i, section: 0)
            let mainCell = zeroXCollectionView.cellForItem(at: indexPath) as! CollectionViewCell
            mainCell.backgroundColor = UIColor.clear
            mainCell.IBimgView.image = UIImage(named: "img_Blank")
            //zeroXCollectionView.deselectItem(at: indexPath, animated: false)
        }
        zeroXCollectionView.allowsSelection = true
     }
}
extension ZeroxCollectionViewController: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 9
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            return cell
        }
}
extension ZeroxCollectionViewController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            count += 1
            if count % 2 == 0{
                cell.IBimgView.image = UIImage(named: "img_Zero")
                arrZero.append(indexPath.row)
                checkCrossValue()
            }else{
                cell.IBimgView.image = UIImage(named: "img_Cross")
                arrCross.append(indexPath.row)
                checkCrossValue()
            }
        }
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            count -= 1
        }
}
