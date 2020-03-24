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
    @IBOutlet weak var checkPasswordIcon: UIImageView!
    @IBOutlet weak var checkPasswordLabel: UILabel!
    let initUsername = "Robusta"
    let initPassword = "Robusta.123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        checkForEmptyTextField()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLoginSuccess" {
            let loginSuccessVC = segue.destination as! LoginSuccessViewController
            loginSuccessVC.username = initUsername
        }
    }
    
    func loginAuthentication() {
        if usernameTextField.text == initUsername && passwordTextField.text == initPassword {
            self.performSegue(withIdentifier: "goToLoginSuccess", sender: self)
        } else {
            loginAuthenticationAlert()
        }
    }
    
    func checkForEmptyTextField() {
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            checkForEmptyTextFieldAlert()
            
        } else {
            if checkPasswordPattern() == false {
                checkPasswordIcon.tintColor = .red
            } else {
                checkPasswordIcon.tintColor = .green
                checkPasswordLabel.font = UIFont.boldSystemFont(ofSize: 10)
            }
            loginAuthentication()
        }
    }
    
    func checkForEmptyTextFieldAlert() {
        let alert = UIAlertController(title: "Error", message: "Please, Username and Password required", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func loginAuthenticationAlert() {
        let alert = UIAlertController(title: "Invalid Credentials", message: "Wrong Email or Password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func checkPasswordPattern() -> Bool {
        let string = passwordTextField.text!
        let regex = try! NSRegularExpression(pattern: "(?=.{8,})")
        let passwordPatternChecked = regex.matches(string)
        return passwordPatternChecked
    }
}

