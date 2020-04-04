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
    let registeredUser = RegisteredUser()
    let segueID = "goToHomeVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        checkForEmptyTextField()
    }
    
    func usernameDataToBePassed() {
        userName = usernameTextField.text
    }
    
    func loginAuthentication() {
        if usernameTextField.text == registeredUser.username && passwordTextField.text == registeredUser.password {
            usernameDataToBePassed()
            self.performSegue(withIdentifier: segueID, sender: self)
        } else {
            loginAuthenticationAlert()
        }
    }
    
    func checkForEmptyTextField() {
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            emptyTextFieldAlert()
            
        } else {
            if checkPasswordPattern() == false {
                displayUIPasswordPatternError(caseType: .failure)
            } else {
                displayUIPasswordPatternError(caseType: .success)
            }
            loginAuthentication()
        }
    }
    
    func emptyTextFieldAlert() {
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
    
    func displayUIPasswordPatternError (caseType: UIErrorCase) {
        switch caseType {
        case .success:
            checkPasswordIcon.image = UIImage(systemName: "checkmark.circle.fill")
            checkPasswordIcon.tintColor = .green
            checkPasswordLabel.text = "Accepted password pattern"
            checkPasswordLabel.textColor = .green
        case .failure:
            checkPasswordIcon.image = UIImage(systemName: "xmark.circle.fill")
            checkPasswordIcon.tintColor = .red
            checkPasswordLabel.textColor = .red
        }
    }
}

