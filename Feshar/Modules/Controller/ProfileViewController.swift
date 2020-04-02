//
//  ProfileViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/2/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userDataTabelView: UITableView!
    var usernameLoggedIn: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayUsernameLoggedIn()
    }
    
    func displayUsernameLoggedIn() {
        if let usernameLoggedIn = usernameLoggedIn {
            usernameLabel.text = usernameLoggedIn
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
