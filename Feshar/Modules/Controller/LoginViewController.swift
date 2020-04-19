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
    fileprivate let segueID = "goToHomeVC"
    fileprivate var safeUsername = ""
    fileprivate var safePassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordIcon.image = UIImage(systemName: " ")
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        createLoginRequest()
    }
    
    func usernameDataToBePassed() {
        userName = usernameTextField.text
    }
}



//MARK: - Authentication
extension LoginViewController {
    func createLoginRequest() {
        fetchAccessToken { (data: RequestTokenResponse?) in
            guard let data = data else { return }
            self.fetchLogin(requestToken: data.requestToken) { [weak self] (response: LoginResponse?) in
                guard let response = response else { return }
                guard let success = response.success else { return }
                if success {
                    print("hi")
                    DispatchQueue.main.async {
                        self?.performSegue(withIdentifier: self!.segueID, sender: self)
                    }
                    guard let resquestToken = response.requestToken else { return }
                    self?.fetchSessionId(requestToken: resquestToken) { (sessionResponse: SessionResponse?) in
                        guard let sessionResponse = sessionResponse else { return }
                        if sessionResponse.success {
                            sessionID = sessionResponse.sessionID
                            print(sessionID!)
                        }
                    }
                } else {
                    print("no hi")
                    self?.loginAuthenticationAlert()
                }
            }
        }
    }
    
    
    func checkForEmptyTextField() -> Bool {
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            return false
        }
        return true
    }
    
    func passwordPatternResult() -> Bool {
        if checkPasswordPattern() {
            displayUIPasswordPatternError(caseType: .success)
            return true
        } else {
            displayUIPasswordPatternError(caseType: .failure)
            return false
        }
    }
    
    func checkPasswordPattern() -> Bool {
        let string = passwordTextField.text!
        let regex = try! NSRegularExpression(pattern: "(?=.{8,})")
        let passwordPatternChecked = regex.matches(string)
        return passwordPatternChecked
    }
    
    func displayUIPasswordPatternError(caseType: UIErrorCase) {
        DispatchQueue.main.async {
            switch caseType {
            case .success:
                self.checkPasswordIcon.image = UIImage(systemName: " ")
                self.checkPasswordLabel.text = "Accepted password pattern"
                self.checkPasswordLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.6768245962, blue: 0.1411764771, alpha: 1)
            case .failure:
                self.checkPasswordIcon.image = UIImage(systemName: "exclamationmark.triangle.fill")
                self.checkPasswordIcon.tintColor = #colorLiteral(red: 0.9719498754, green: 0.876349628, blue: 0, alpha: 1)
                self.checkPasswordLabel.textColor = #colorLiteral(red: 0.9780631661, green: 0.08815162629, blue: 0.1542625129, alpha: 1)
                self.checkPasswordLabel.text = "Password must be at least 8 characters"
            }
        }
        
    }
}



//MARK: - Custom Alert
extension LoginViewController {
    func displayAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func emptyTextFieldAlert() {
        DispatchQueue.main.async {
            self.displayAlert(title: "Error", message: "Username and Password required")
        }
    }
    
    func loginAuthenticationAlert() {
        DispatchQueue.main.async {
            self.displayAlert(title: "Invalid Credentials", message: "Wrong Email or Password")
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
        DispatchQueue.main.sync {
            if checkForEmptyTextField() {
                guard passwordPatternResult() else { return }
                self.safeUsername = self.usernameTextField.text!
                self.safePassword = self.passwordTextField.text!
                
                let networkManager = NetworkManager()
                let postData = try! JSONEncoder().encode(LoginRequest(username: safeUsername, password: safePassword, requestToken: requestToken))
                
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
            
            emptyTextFieldAlert()
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
