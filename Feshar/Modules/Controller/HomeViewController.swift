//
//  HomeViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/30/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var movieTypeCollectionView: UICollectionView!
    let movieTypeIdentifier = "MovieTypesCollectionViewCell"
    let movieCellIdentifier = "MovieTableViewCell"
    let movieTypeButtonNameArray = ["Romance", "Action", "Comedy"]
    let segueID = "goToWatchlistVC"
    var safeIndexPath = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegateAndDataSource()
        registerCollectionView()
        registerTableView()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func watchlistButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: segueID, sender: self)
    }
    
    @IBAction func featuredButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "goToFeaturedVC", sender: self)
    }
    
    func setupDelegateAndDataSource() {
        movieTypeCollectionView.delegate = self
        movieTypeCollectionView.dataSource = self
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
    
    func registerCollectionView() {
        movieTypeCollectionView.register(UINib.init(nibName: movieTypeIdentifier, bundle: nil), forCellWithReuseIdentifier: movieTypeIdentifier)
    }
    
    func registerTableView() {
        movieTableView.register(UINib.init(nibName: movieCellIdentifier, bundle: nil), forCellReuseIdentifier: movieCellIdentifier)
    }
    
    func displayShareSheet() {
        let alertController = UIAlertController(title: "Action Sheet", message: "What would you like to do?", preferredStyle: .actionSheet)
        let shareOnFacebook = UIAlertAction(title: "Share on Facebook", style: .default, handler: nil)
        let shareOnTwitter = UIAlertAction(title: "Share on Twitter", style: .default, handler: { (action) -> Void in
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(shareOnFacebook)
        alertController.addAction(shareOnTwitter)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDetailsVC" {
            let movieDetailsDataToBePassed = segue.destination as! MovieDetailsViewController
            movieDetailsDataToBePassed.movieDetailsDataPassed = safeIndexPath
        }
    }

}



//MARK: - Setup Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieTypeCollectionView.dequeueReusableCell(withReuseIdentifier: movieTypeIdentifier, for: indexPath) as! MovieTypesCollectionViewCell
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }
}



//MARK: - Setup Table View
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieData().movieNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieTableViewCell
        cell.displayMovieData(movieName: MovieData().movieNameArray[indexPath.row], movieDetails: MovieData().movieDetailsArray[indexPath.row], movieType: MovieData().movieTypeArray[indexPath.row], movieRate: MovieData().movieRateArray[indexPath.row], movieDescription: MovieData().movieDescriptionArray[indexPath.row], movieImage: MovieData().movieImageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        safeIndexPath = indexPath.row
        self.performSegue(withIdentifier: "goToMovieDetailsVC", sender: nil)
    }
    
    
    //    swipe to right
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title:  "Add to Wishlist", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Add to Wishlist")
            success(true)
        })
        addAction.image = UIImage(systemName: "wand.and.stars.inverse")
        addAction.backgroundColor = .systemIndigo
        return UISwipeActionsConfiguration(actions: [addAction])
    }
    
    //    swipe to left
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title:  "Share", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            self.displayShareSheet()
        })
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        shareAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
}
