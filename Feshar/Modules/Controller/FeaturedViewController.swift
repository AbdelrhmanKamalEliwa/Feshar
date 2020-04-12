//
//  FeaturedViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    @IBOutlet weak var featuredTableView: UITableView!
    let moviesCellIdentifier = "MoviesTableViewCell"
    let tvShowsCellIdentifier = "TVShowsTableViewCell"
    var moviesArray = [MovieResults]()
    var tvShowsArray = [TVShowResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        featuredTableView.delegate = self
        featuredTableView.dataSource = self
        getMoviesData()
        getTVShowsData()
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
extension FeaturedViewController {
    func setupCustomNavBar() {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.tintColor = UIColor.gray
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 85, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(myLeftSideBarButtonItemTapped(_:)))
        navigationItem.leftBarButtonItem = backBarButton
        let featuredBarButton = UIBarButtonItem(image: UIImage(systemName: "wand.and.stars.inverse"), style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = featuredBarButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!) { goToWatchlistViewController() }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!) { logout() }
}



//MARK: - Setup Table View
extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = featuredTableView.dequeueReusableCell(withIdentifier: moviesCellIdentifier, for: indexPath) as! MoviesTableViewCell
            cell.updateCategory(movieNumber: moviesArray)
            cell.categoryTitleLabel.text = categoriesArray[indexPath.row]
            return cell
            
        } else {
            let cell = featuredTableView.dequeueReusableCell(withIdentifier: tvShowsCellIdentifier, for: indexPath) as! TVShowsTableViewCell
            cell.updateCategory(movieNumber: tvShowsArray)
            cell.categoryTitleLabel.text = categoriesArray[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 232
    }
}


//MARK: - Networking
extension FeaturedViewController {
    
    func getMoviesData() {
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getMovies, httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<MovieModel>) in
            switch result {
                
            case .success(let data):
                self.moviesArray = data.results
                DispatchQueue.main.async {
                    self.featuredTableView.reloadData()
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
    
    func getTVShowsData() {
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getTVShows, httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<TVShowModel>) in
            switch result {
                
            case .success(let data):
                self.tvShowsArray = data.results
                DispatchQueue.main.async {
                    self.featuredTableView.reloadData()
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
    
}
