//
//  WatchlistViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController {
    
    @IBOutlet weak var watchlistTableView: UITableView!
    let watchlistCellIdentifier = "WatchlistTableViewCell"
    var watchlistMoviesArray = [WatchlistMovieResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        setupDelegateAndDataSource()
        registerTableView()
        WatchlistNetworkManager().fetchWatchlistMoviesData { (data: WatchlistMovieModel?) in
            if let data = data {
                self.watchlistMoviesArray = data.results
                actualWatchlistMoviesArray = data.results
                DispatchQueue.main.async {
                    self.watchlistTableView.reloadData()
                }
            }
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupDelegateAndDataSource() {
        watchlistTableView.delegate = self
        watchlistTableView.dataSource = self
    }
    
    func registerTableView() {
        watchlistTableView.register(UINib.init(nibName: watchlistCellIdentifier, bundle: nil), forCellReuseIdentifier: watchlistCellIdentifier)
    }
    
    func backToPreviousViewController() { self.navigationController?.popViewController(animated: true) }
}



//MARK: - Setup Custome Nav-Bar
extension WatchlistViewController {
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
        let settingBarButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = settingBarButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!) {
        print("myRightSideBarButtonItemTapped")
    }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!) { backToPreviousViewController() }
}



//MARK: - Setup Table View
extension WatchlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlistMoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = watchlistTableView.dequeueReusableCell(withIdentifier: watchlistCellIdentifier, for: indexPath) as! WatchlistTableViewCell
        cell.displayMovieData(movieName: watchlistMoviesArray[indexPath.row].title, movieDetails: watchlistMoviesArray[indexPath.row].title, movieRate: String(watchlistMoviesArray[indexPath.row].imdbRate), movieImage: EndPointRouter.getMoviePoster(posterPath: watchlistMoviesArray[indexPath.row].poster))
        return cell
    }
    
    
    
    //    swipe to left
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "Remove", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            WatchlistNetworkManager().fetchDeleteFromWatchlistMovies(mediaId: self.watchlistMoviesArray[indexPath.row].id) { (addToWatchlistResponse: AddToWatchlistResponse?) in
                DispatchQueue.main.async {
                    if let addToWatchlistResponse = addToWatchlistResponse {
                        let alert = UIAlertController(title: "SUCCESS" , message: addToWatchlistResponse.statusMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                        WatchlistNetworkManager().fetchWatchlistMoviesData { (data: WatchlistMovieModel?) in
                            if let data = data {
                                print("hi")
                                self.watchlistMoviesArray = data.results
                                self.watchlistTableView.reloadData()
                            }
                        }
                    }
                }
            }
            
//            WatchlistNetworkManager().fetchWatchlistMoviesData { (data: WatchlistMovieModel?) in
//                if let data = data {
//                    DispatchQueue.main.async {
//                        print("hi")
//                        self.watchlistMoviesArray = data.results
//                        self.watchlistTableView.reloadData()
//                    }
//                }
//            }
            
            success(true)
            
        })
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
