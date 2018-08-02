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
    var arrCross = [Int]()
    var arrZero =  [Int]()
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
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        IBlblDesision.isHidden = true
        
      
//        IBlblPlayerOne.text = playerOneName
//        IBlblPlayerTwo.text = playerTwoName

    }
    private func setUpCollectionView(){
        zeroXCollectionView.allowsMultipleSelection = true
        zeroXCollectionView.register(UINib(nibName: "CollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        zeroXCollectionView.layer.cornerRadius = 15.0
        zeroXCollectionView.clipsToBounds = true
        addShadow(to: zeroXCollectionView.layer, with: 5.0)
        zeroXCollectionView.layer.masksToBounds = false
    }
    private func addLine(from startPoint: CGPoint, to endPoint: CGPoint, collView:UIView){
        // create path
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)

        // Create a `CAShapeLayer` that uses that `UIBezierPath`:
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.lineJoin = kCALineJoinBevel
        addShadow(to: shapeLayer, with: 3.0)
        
        // Add that `CAShapeLayer` to your view's layer:
        UIView.animate(withDuration: 1, animations: {
            self.view.layer.addSublayer(shapeLayer)
        })
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 0.3
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        shapeLayer.add(pathAnimation, forKey: "strokeEnd")
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
                    
                    guard let cell =  zeroXCollectionView.cellForItem(at: indexPath as IndexPath) as? CollectionViewCell else { return }
                   getStartEndPoint(from: indexPath)
                    //cell.backgroundColor = UIColor.green
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
    private func getStartEndPoint(from indexpath: IndexPath){
        let attributes: UICollectionViewLayoutAttributes? = zeroXCollectionView.layoutAttributesForItem(at: indexpath)
        let cellRect: CGRect? = attributes?.frame
        let cellFrameInSuperview = zeroXCollectionView.convert(cellRect ?? CGRect.zero, to: zeroXCollectionView.superview)
        linePosition.append(CGPoint(x:cellFrameInSuperview.origin.x , y: cellFrameInSuperview.origin.y))
        let width = cellFrameInSuperview.size.width
        if linePosition.count == 3{
            
            addLine(from: CGPoint(x: linePosition[0].x + (width / 2) , y: linePosition[0].y + (width / 2)), to: CGPoint(x: linePosition[2].x + (width - (width / 2)), y: linePosition[2].y + (width - (width / 2))), collView: zeroXCollectionView)
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
    private func addAnimationToImgView(img: UIImage,imgView: UIImageView){
        UIView.transition(with: imgView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.addShadow(to: imgView.layer, with: 1.0)
            imgView.image = img
        }, completion: nil)
    }
    private func addShadow(to layer: CALayer, with raious : CGFloat){
       layer.shadowColor = UIColor.gray.cgColor
       layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
       layer.shadowOpacity = 3.0
       layer.shadowRadius = raious
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            count += 1
            if count % 2 == 0{
                addAnimationToImgView(img: #imageLiteral(resourceName: "zero"), imgView: cell.IBimgView)
                arrZero.append(indexPath.row)
                checkCrossValue()
            }else{
               addAnimationToImgView(img: #imageLiteral(resourceName: "close"), imgView: cell.IBimgView)
                arrCross.append(indexPath.row)
                checkCrossValue()
            }

    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        count -= 1
    }
}
