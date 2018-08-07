//
//  ZeroxCollectionViewController.swift
//  TicTacToe
//
//  Created by dhara.patel on 06/03/17.
//  Copyright © 2017 SASA. All rights reserved.
//

import UIKit
import  AVFoundation

class ZeroxCollectionViewController: UIViewController {

    var count = 0
    var linePosition = [CGPoint]()
    var cellFrames = [CGRect]()
    var arrCross = [Int]()
    var arrZero =  [Int]()
    var audioPlayer = AVAudioPlayer()
    var audioPlayer1 = AVAudioPlayer()
    var backgroundPlayer = AVAudioPlayer()
    let arrPosibileValue = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    @IBOutlet weak var whoseTurnImage: UIImageView!
    @IBOutlet weak var IBlblDesision: UILabel!
    @IBOutlet weak var IBlblPlayerOne: UILabel!
    @IBOutlet weak var IBlblPlayerTwo: UILabel!
    @IBOutlet weak var zeroXCollectionView: UICollectionView!{
        didSet{
            setUpCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        IBlblDesision.isHidden = true
        getWhoseturn(is: true)
        playBackfroundMusic(str: "background.mp3")
    }
    
    private func setUpCollectionView(){
        zeroXCollectionView.allowsMultipleSelection = true
        zeroXCollectionView.register(UINib(nibName: "CollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        zeroXCollectionView.layer.cornerRadius = 15.0
        zeroXCollectionView.clipsToBounds = true
        zeroXCollectionView.layer.masksToBounds = false
    }
    private func playAudio(str: String){
 
        let path = Bundle.main.path(forResource: str, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error{
            print(error)
            // couldn't load file :(
        }
    }
    private func playCompleteGameAudio(str: String){
        
        let path = Bundle.main.path(forResource: str, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer1 = try AVAudioPlayer(contentsOf: url)
            audioPlayer1.prepareToPlay()
            audioPlayer1.play()
        } catch let error{
            print(error)
            // couldn't load file :(
        }
    }
    private func playBackfroundMusic(str: String){
        
        let path = Bundle.main.path(forResource: str, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer.numberOfLoops = -1
            backgroundPlayer.prepareToPlay()
            backgroundPlayer.play()
        } catch let error{
            print(error)
            // couldn't load file :(
        }
    }
}

extension ZeroxCollectionViewController{
    private func getWhoseturn(is love:Bool){
        if love{
            whoseTurnImage.image = #imageLiteral(resourceName: "love")
        }else{
            whoseTurnImage.image = #imageLiteral(resourceName: "hate")
        }
        whoseTurnAnimation(imgView: whoseTurnImage)
        
    }
    private func whoseTurnAnimation(imgView: UIImageView){
        UIView.animate(withDuration: 1.2, delay: 0, options: .repeat, animations: {
            imgView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            imgView.alpha = 1.0
        }, completion: { (finished) in
            UIView.animate(withDuration: 1, delay: 0, options: .repeat, animations: {() -> Void in
                imgView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
    }
    private func checkCrossValue(){
        for i in arrPosibileValue{
            let sPosibilitiesList = Set(i)
            var sCrossOrZeroLost = Set<Int>() //crossValue or zeroValue
            var message = String()
            if count % 2 == 0{ //if count even then zero otherwise cross
                getWhoseturn(is: true)
                sCrossOrZeroLost = Set(arrZero)
                message = "Hate win 😈"
            }else{
                getWhoseturn(is: false)
                sCrossOrZeroLost = Set(arrCross)
                message = "Love win 😍"
            }
            
            //check arrayValue elements contain in cross array or zero array
            if sPosibilitiesList.isSubset(of: sCrossOrZeroLost){
                for j in i{
                    let indexPath = IndexPath(item: j, section: 0)
                    
                    //tp draw line fro final result
                    getStartEndPoint(from: indexPath)
                }
                IBlblDesision.isHidden = false
                IBlblDesision.text = message
                zeroXCollectionView.allowsSelection = false
                break
            }else if count == 9 {
                IBlblDesision.isHidden = false
                IBlblDesision.text = "Tie 😎"
            }
        }
    }
}
//MARK:- Draw Line Method

extension ZeroxCollectionViewController{
    
    private func getStartEndPoint(from indexpath: IndexPath){
        //get frame of cell
        let cellFrame = zeroXCollectionView.makeStartEndPoint(on: indexpath)
        linePosition.append(CGPoint(x:cellFrame.origin.x , y: cellFrame.origin.y))
        let width = cellFrame.size.width
        if linePosition.count == 3{
        
            Helper.addLine(from: CGPoint(x: linePosition[0].x + (width / 2) , y: linePosition[0].y + (width / 2)), to: CGPoint(x: linePosition[2].x + (width - (width / 2)), y: linePosition[2].y + (width - (width / 2))), view: self.view, duration: 0.4, strokeColor: .green, width: 5, delay: 0.3)
            playCompleteGameAudio(str: "win.mp3")
        }
    }
    
    private func getframeToDrawLine(on frame: CGRect ) ->(x: CGFloat,y:CGFloat,width:CGFloat,height: CGFloat){
        return(x: frame.origin.x,y:frame.origin.y,width: frame.size.width,height: frame.size.height)
    }
    
    private func getframeToDrawColumn(from this: CGRect, to that: CGRect ,delay:Double) {
        
        let space:CGFloat = 5
        let lineFrom = getframeToDrawLine(on: this)
        let lineTo = getframeToDrawLine(on: that)
        
        Helper.addLine(from: CGPoint(x: (lineFrom.x + lineFrom.width) + space, y: lineFrom.y), to: CGPoint(x:(lineTo.x + lineTo.width) + space, y: (lineTo.y + lineTo.height)), view: self.view, duration: 0.4, strokeColor: .blue, delay: delay)
    }
    private func getframeToDrawRow(from this: CGRect, to that: CGRect ,delay:Double) {
        
        let space:CGFloat = 5
        let lineFrom = getframeToDrawLine(on: this)
        let lineTo = getframeToDrawLine(on: that)
        
        Helper.addLine(from: CGPoint(x: lineFrom.x, y: (lineFrom.y + lineFrom.height) + space), to: CGPoint(x:(lineTo.x + lineTo.width), y: (lineTo.y + lineTo.height) + space), view: self.view, duration: 0.4, strokeColor: .blue, delay: delay)
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
            
            //to draw first column
            getframeToDrawColumn(from: cellFrames[0], to: cellFrames[6],delay:0.1)
            
            //to draw second column
            getframeToDrawColumn(from: cellFrames[1], to: cellFrames[7],delay:0.6)
            
            //to draw first row
            getframeToDrawRow(from: cellFrames[0], to: cellFrames[2], delay: 1.0)
            
            //to draw second row
            getframeToDrawRow(from: cellFrames[3], to: cellFrames[5], delay: 1.5)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if cell.IBimgView.image != nil{
            return
        }
        count += 1
            if count % 2 == 0{
                cell.configureCell(true)
                arrZero.append(indexPath.row)
                checkCrossValue()
            }else{
                cell.configureCell(false)
                arrCross.append(indexPath.row)
                checkCrossValue()
            }
        playAudio(str: "tick.mp3")
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
