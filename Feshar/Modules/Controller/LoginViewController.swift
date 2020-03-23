//
//  ViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/23/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let userName = "Robusta"
    let password = "Robusta.123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultDisplay()
    }

    @IBAction func login(_ sender: Any) {
        if usernameTextField.text == userName && passwordTextField.text == password {
            self.performSegue(withIdentifier: "goToLoginSuccess", sender: self)
        } else {
            self.performSegue(withIdentifier: "goToLoginFailure", sender: self)
        }
    }
    
    func defaultDisplay() {
        usernameTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 25
    }
}

