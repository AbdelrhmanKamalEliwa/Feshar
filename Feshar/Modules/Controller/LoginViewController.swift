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
    fileprivate var canLogin = false
    fileprivate var sessionUsername = ""
    fileprivate var sessionPassword = ""
    fileprivate var safeUsername = ""
    fileprivate var safePassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordIcon.image = UIImage(systemName: " ")
        createLoginRequest()
        
    }
    
    func createLoginRequest() {
        fetchAccessToken { (data: RequestTokenResponse?) in
            if let data = data {
                self.fetchLogin(requestToken: data.requestToken) { (response: LoginResponse?) in
                    if let response = response {
                        if let success = response.success {
                            if success {
                            self.canLogin = success
                            //TODO: set username & password
                                
                            }
                        }
                        if let resquestToken = response.requestToken {
                            self.fetchSessionId(requestToken: resquestToken) { (sessionResponse: SessionResponse?) in
                                if let sessionResponse = sessionResponse {
                                    if sessionResponse.success { self.canLogin = sessionResponse.success }
                                    sessionID = sessionResponse.sessionID
                                    print(sessionID!)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        checkForEmptyTextField()
    }
    
    func usernameDataToBePassed() {
        userName = usernameTextField.text
    }
    
    func loginAuthentication() {
//        sessionUsername = usernameTextField.text!
//        sessionPassword = passwordTextField.text!
        if usernameTextField.text == registeredUser.username && passwordTextField.text == registeredUser.password && canLogin {
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


//MARK: - Networking
extension LoginViewController {
    
    func fetchAccessToken(comletion: @escaping(_ data: RequestTokenResponse?) -> ()) {
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.createRequestToken, httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<RequestTokenResponse>) in
            switch result {
            case .success(let data):
                comletion(data)
            case .failure(let error):
                if let error = error {
                    print(error)
                }
            case .decodingFailure(let error):
                if let error = error {
                    print(error)
                }
            case .badRequest(let error):
                if let error = error {
                    print(error)
                }
            }
        }
        
    }
    
    
    func fetchLogin(requestToken: String, completion: @escaping(_ response: LoginResponse?) -> ()) {
        let networkManager = NetworkManager()
        let postData = try! JSONEncoder().encode(LoginRequest(username: RegisteredUser().username, password: RegisteredUser().password, requestToken: requestToken))
        
        let _ = networkManager.request(url: EndPointRouter.createLoginAuthentication, httpMethod: .post, parameters: postData, headers: ["Content-Type":"application/json"]) { (result: APIResult<LoginResponse>) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                if let error = error {
                    print(error)
                }
            case .decodingFailure(let error):
                if let error = error {
                    print(error)
                }
            case .badRequest(let error):
                if let error = error {
                    print(error)
                }
            }
        }
        
    }
    
    
    func fetchSessionId(requestToken: String, completion: @escaping(_ sessionResponse: SessionResponse?) -> ()) {
        let networkManager = NetworkManager()
        let postData = try! JSONEncoder().encode(SessionRequest(requestToken: requestToken))
        
        let _ = networkManager.request(url: EndPointRouter.createSessionId, httpMethod: .post, parameters: postData, headers: ["Content-Type":"application/json"]) { (result: APIResult<SessionResponse>) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                if let error = error {
                    print(error)
                }
            case .decodingFailure(let error):
                if let error = error {
                    print(error)
                }
            case .badRequest(let error):
                if let error = error {
                    print(error)
                }
                
            }
        }
    }
    
    
}
