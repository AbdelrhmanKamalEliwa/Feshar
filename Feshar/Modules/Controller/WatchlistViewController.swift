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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegateAndDataSource()
        registerTableView()
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
}




//MARK: - Setup Table View
extension WatchlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WatchlistData().movieNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = watchlistTableView.dequeueReusableCell(withIdentifier: watchlistCellIdentifier, for: indexPath) as! WatchlistTableViewCell
        cell.displayMovieData(movieName: WatchlistData().movieNameArray[indexPath.row], movieDetails: WatchlistData().movieDetailsArray[indexPath.row], movieRate: WatchlistData().movieRateArray[indexPath.row], movieImage: WatchlistData().movieImageArray[indexPath.row])
        return cell
    }
    
    
    
    //    swipe to left
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Movie Deleted")
            success(true)
        })
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
