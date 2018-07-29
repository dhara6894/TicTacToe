//
//  LoginViewController.swift
//  TicTacToe
//
//  Created by dhara.patel on 07/03/17.
//  Copyright © 2017 SASA. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

    @IBOutlet weak var IBtxtP1Name: UITextField!
    @IBOutlet weak var IBtxtP2BName: UITextField!
    override func viewDidLoad() {
    super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnLetsPlayClick(_ sender: Any) {
        let controller = ZeroxCollectionViewController(nibName: "ZeroxCollectionViewController", bundle: nil)
        controller.playerOneName = IBtxtP1Name.text!
        controller.playerTwoName = IBtxtP2BName.text!
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
