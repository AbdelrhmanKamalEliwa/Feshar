//
//  ProfileViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/2/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var userDataTabelView: UITableView!
    fileprivate let profileCellIdentifier = "ProfileInfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegateAndDataSource()
        registerTableView()
        setupCustomNavBar()
        getUserInfo()
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
        let backBarButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(myLeftSideBarButtonItemTapped(_:)))
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.08921027929, blue: 0.1636223793, alpha: 1)
        let featuredBarButton = UIBarButtonItem(image: UIImage(systemName: "wand.and.stars.inverse"), style: .done, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = featuredBarButton
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6209790111, green: 0.3204901814, blue: 0, alpha: 1)
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
    
    func setupDelegateAndDataSource() {
        userDataTabelView.delegate = self
        userDataTabelView.dataSource = self
    }
    
    func registerTableView() {
        userDataTabelView.register(UINib.init(nibName: profileCellIdentifier, bundle: nil), forCellReuseIdentifier: profileCellIdentifier)
    }
}


//MARK: - Networking
extension ProfileViewController {
    func getUserInfo() {
        guard let sessionId = sessionID else { return }
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getAccountInfo(sessionId: sessionId), httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<AccountInfo>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.usernameLabel.text = data.username
                }
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
    
    func logout() {
        guard let validSessionId = sessionID else { return }
        LogoutNetworkManager().logout(sessionId: validSessionId) { (response: LogoutResponse?) in
            guard let safeResponse = response else { return }
            if safeResponse.success {
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss(animated: true, completion: nil)
                    sessionID = nil
                }
            }
        }
    }
}
