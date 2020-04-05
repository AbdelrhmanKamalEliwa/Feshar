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
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordIcon.image = UIImage(systemName: " ")
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
            checkPasswordIcon.image = UIImage(systemName: " ")
            checkPasswordLabel.text = "Accepted password pattern"
            checkPasswordLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.6768245962, blue: 0.1411764771, alpha: 1)
        case .failure:
            checkPasswordIcon.image = UIImage(systemName: "exclamationmark.triangle.fill")
            checkPasswordIcon.tintColor = #colorLiteral(red: 0.9719498754, green: 0.876349628, blue: 0, alpha: 1)
            checkPasswordLabel.textColor = #colorLiteral(red: 0.9780631661, green: 0.08815162629, blue: 0.1542625129, alpha: 1)
            checkPasswordLabel.text = "Password must be at least 8 characters"
        }
    }
}


//MARK: - Text Field Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
