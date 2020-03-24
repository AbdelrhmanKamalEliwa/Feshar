//
//  LoginSuccessViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/23/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class LoginSuccessViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = username
//        usernameLabel.attributedText = coloredUsername
    }
    
//    func displayColoredUsername() -> NSAttributedString {
//        let firstAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
//        let firstString = NSMutableAttributedString(string: "Hello, ", attributes: firstAttributes)
//        let secondString = NSAttributedString(string: "\(username)", attributes: secondAttributes)
//        let coloredUsername = firstString.append(secondString)
//        return coloredUsername
//    }
}

