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
    let profileCellIdentifier = "ProfileInfoTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegateAndDataSource()
        registerTableView()
        displayUsernameLoggedIn()
        setupCustomNavBar()
    }
    
    func displayUsernameLoggedIn() {
        if let userName = userName {
            usernameLabel.text = userName
        }
    }
    
    func setupDelegateAndDataSource() {
        userDataTabelView.delegate = self
        userDataTabelView.dataSource = self
    }
    
    func registerTableView() {
        userDataTabelView.register(UINib.init(nibName: profileCellIdentifier, bundle: nil), forCellReuseIdentifier: profileCellIdentifier)
    }
    
    func logout() {
        if let sessionId = sessionID {
            LogoutNetworkManager().logout(sessionId: sessionId) { (response: LogoutResponse?) in
                if let response = response {
                    if response.success {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                            sessionID = nil
                        }
                    }
                }
            }
        }
    }
    
    func goToWatchlistViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let watchlistViewController = storyboard.instantiateViewController(identifier: "WatchlistViewController") as! WatchlistViewController
        self.navigationController?.pushViewController(watchlistViewController, animated: true)
    }
}



//MARK: - Setup Custome Nav-Bar
extension ProfileViewController {
    func setupCustomNavBar() {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.tintColor = UIColor.gray
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 85, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(myLeftSideBarButtonItemTapped))
        navigationItem.leftBarButtonItem = backBarButton
        let featuredBarButton = UIBarButtonItem(image: UIImage(systemName: "wand.and.stars.inverse"), style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped))
        navigationItem.rightBarButtonItem = featuredBarButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!) { goToWatchlistViewController() }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!) { logout() }
}



//MARK: - Setup Table View
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = userDataTabelView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as! ProfileInfoTableViewCell
        
        if indexPath.row == 0 {
            cell.displayCell(cellTitle: "Mobile", cellData: "+1 (202) 555-0158")
        } else if indexPath.row == 1 {
            cell.displayCell(cellTitle: "Email", cellData: "Feshara@feshar.ai")
        } else if indexPath.row == 2 {
            cell.displayCell(cellTitle: "Favourite Movie", cellData: "The Good fellas")
        } else if indexPath.row == 3 {
            cell.displayCell(cellTitle: "Favourite show", cellData: "Atlanta")
        }
        
        return cell
    }
    
    
}
