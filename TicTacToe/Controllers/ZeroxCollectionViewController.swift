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
    var linePosition = [CGPoint]()
    var cellFrames = [CGRect]()
    var arrCross = [Int]()
    var arrZero =  [Int]()
    var selectedValue = [Int]()
    let arrPosibileValue = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    @IBOutlet weak var zeroXCollectionView: UICollectionView!{
        didSet{
            setUpCollectionView()
        }
    }
    @IBOutlet weak var IBlblDesision: UILabel!
    @IBOutlet weak var IBlblPlayerOne: UILabel!
    @IBOutlet weak var IBlblPlayerTwo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        IBlblDesision.isHidden = true
    //  IBlblPlayerOne.text = playerOneName
    //  IBlblPlayerTwo.text = playerTwoName
    }
    private func setUpCollectionView(){
        zeroXCollectionView.allowsMultipleSelection = true
        zeroXCollectionView.register(UINib(nibName: "CollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        zeroXCollectionView.layer.cornerRadius = 15.0
        zeroXCollectionView.clipsToBounds = true
        //Helper.addShadow(to: zeroXCollectionView.layer, with: 5.0)
        zeroXCollectionView.layer.masksToBounds = false
    }
}

extension ZeroxCollectionViewController{
    
    private func checkCrossValue(){
        for i in arrPosibileValue{
            let sPosibilitiesList = Set(i)                                   //arrayValue
            var sCrossOrZeroLost = Set<Int>()                                //crossValue or zeroValue
            var message = String()
            if count % 2 == 0{                                     //check for cross or zero
                sCrossOrZeroLost = Set(arrZero)
                message = "Unfortunately \(playerTwoName) Won.. Well played \(playerOneName)"
            }else{
                sCrossOrZeroLost = Set(arrCross)
                message = "\(playerOneName) Won"
            }
            
            //check arrayValue elements contain in cross array or zero array
            if sPosibilitiesList.isSubset(of: sCrossOrZeroLost){
                for j in i{             //if match with posibilities than color it
                let indexPath = IndexPath(item: j, section: 0)
                   getStartEndPoint(from: indexPath)
                   zeroXCollectionView.deselectItem(at: indexPath, animated: false)
                }
                IBlblDesision.isHidden = false
                IBlblDesision.text = message
                zeroXCollectionView.allowsSelection = false
                break
            }else{
                if count == 9{
                    IBlblDesision.isHidden = false
                    IBlblDesision.text = "Tie"
                }
            }
        }
    }
    private func getStartEndPoint(from indexpath: IndexPath){
        //get frame of cell
       let cellFrame = zeroXCollectionView.makeStartEndPoint(on: indexpath)
        linePosition.append(CGPoint(x:cellFrame.origin.x , y: cellFrame.origin.y))
        let width = cellFrame.size.width
        if linePosition.count == 3{

            Helper.addLine(from: CGPoint(x: linePosition[0].x + (width / 2) , y: linePosition[0].y + (width / 2)), to: CGPoint(x: linePosition[2].x + (width - (width / 2)), y: linePosition[2].y + (width - (width / 2))), view: self.view, duration: 0.4, strokeColor: .green, width: 5, delay: 0.3)
        }
    }
}

//MARK:- Actions Method

extension ZeroxCollectionViewController{
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

//MARK:- UICollectionViewDataSource Method

extension ZeroxCollectionViewController: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 9
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            return cell
        }
}

//MARK:- UICollectionViewDelegate Method

extension ZeroxCollectionViewController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //get frame of cell
        
        let cellFrame = zeroXCollectionView.makeStartEndPoint(on: indexPath)
        cellFrames.append(cellFrame)
        
        if indexPath.row == 8{
            Helper.addLine(from: CGPoint(x: (self.cellFrames[0].origin.x + self.cellFrames[0].size.width) + 5, y: self.cellFrames[0].origin.y), to: CGPoint(x:(self.cellFrames[6].origin.x + self.cellFrames[6].size.width) + 5, y: (self.cellFrames[6].origin.y + self.cellFrames[6].size.height)), view: self.view, duration: 0.4, strokeColor: .blue, delay: 0.1)

            Helper.addLine(from: CGPoint(x: (self.cellFrames[1].origin.x + self.cellFrames[1].size.width) + 5, y: self.cellFrames[1].origin.y), to: CGPoint(x:(self.cellFrames[7].origin.x + self.cellFrames[7].size.width) + 5, y: (self.cellFrames[7].origin.y + self.cellFrames[7].size.height)), view: self.view, duration: 0.4, strokeColor: .blue, delay: 0.6)

            Helper.addLine(from: CGPoint(x: self.cellFrames[0].origin.x , y: (self.cellFrames[0].origin.y + self.cellFrames[0].size.height) + 5), to: CGPoint(x:(self.cellFrames[2].origin.x + self.cellFrames[2].size.width), y: (self.cellFrames[2].origin.y + self.cellFrames[2].size.height) + 5), view: self.view, duration: 0.4, strokeColor: .blue, delay: 1.0)

            Helper.addLine(from: CGPoint(x: self.cellFrames[3].origin.x , y: (self.cellFrames[3].origin.y + self.cellFrames[3].size.height) + 5), to: CGPoint(x:(self.cellFrames[5].origin.x + self.cellFrames[5].size.width), y: (self.cellFrames[5].origin.y + self.cellFrames[5].size.height) + 5), view: self.view, duration: 0.4, strokeColor: .blue, delay: 1.5)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if cell.IBimgView.image != nil{
            return
        }
        count += 1
            if count % 2 == 0{
                cell.IBimgView.image = #imageLiteral(resourceName: "hate")
                Helper.likeAnimation(imgView: cell.IBimgView)
                arrZero.append(indexPath.row)
                checkCrossValue()
            }else{
                cell.IBimgView.image = #imageLiteral(resourceName: "love")
                Helper.likeAnimation(imgView: cell.IBimgView)
                arrCross.append(indexPath.row)
                checkCrossValue()
            }
            selectedValue.append(indexPath.row)
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if cell.IBimgView.image == nil{
//            count -= 1
        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout Method

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

