//
//  LoginViewController.swift
//  TicTacToe
//
//  Created by dhara.patel on 07/03/17.
//  Copyright © 2017 SASA. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    var animator = UIDynamicAnimator()
    
    override func viewDidLoad() {
    super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSelectionView()
    }
    
}
extension LoginViewController{
    private func addSelectionView(){
        guard let chooseView = Bundle.main.loadNibNamed("ChooseView", owner: self, options: nil)?.first as? ChooseView else {  return }
        // let chooseView = ChooseView()
        chooseView.frame = CGRect(x: (view.frame.size.width / 2) - 125, y: view.frame.origin.y, width: 250, height: 200)
        Helper.addShadow(to: chooseView.layer, with: 3)
        chooseView.layer.cornerRadius = 15.0
        self.view.addSubview(chooseView)
        addGesture(to: chooseView)
        addBounceAnimation(to: chooseView)
    }
    private func addGesture(to view: ChooseView){
        let loveTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLove))
        view.loveImage.isUserInteractionEnabled = true
        view.loveImage.addGestureRecognizer(loveTapGesture)
       
        let hateTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHate))
        view.haveImage.isUserInteractionEnabled = true
        view.haveImage.addGestureRecognizer(hateTapGesture)
        
    }
    @objc func tapLove(){
       print("love")
        let controller = ZeroxCollectionViewController(nibName: "ZeroxCollectionViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: false)
        
    }
    @objc func tapHate(){
        print("Hate")
        let controller = ZeroxCollectionViewController(nibName: "ZeroxCollectionViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: false)
        
    }
    private func addBounceAnimation(to chooseView: UIView){
        
        animator = UIDynamicAnimator(referenceView: view)
        let gravityBehavior = UIGravityBehavior(items: [chooseView])
        animator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [chooseView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        collisionBehavior.addBoundary(withIdentifier: "barrier" as NSCopying, from: CGPoint(x: self.view.frame.origin.x, y: (self.view.frame.size.height / 2) + 100), to: CGPoint(x: self.view.frame.origin.x + self.view.frame.size.width , y: (self.view.frame.size.height / 2) + 100))
        animator.addBehavior(collisionBehavior)
        
        let elasticityBehavior = UIDynamicItemBehavior(items: [chooseView])
        elasticityBehavior.elasticity = 0.7
        animator.addBehavior(elasticityBehavior)
    }
    @IBAction func btnLetsPlayClick(_ sender: Any) {
        let controller = ZeroxCollectionViewController(nibName: "ZeroxCollectionViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: false)
    }
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
