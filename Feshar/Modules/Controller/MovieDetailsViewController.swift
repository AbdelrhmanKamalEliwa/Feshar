//
//  MovieDetailsViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieNameDetails: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var moviePosterCollectionView: UICollectionView!
    let posterImageArray = ["Star-Wars-Poster_2", "Star-Wars-Poster_3", "Star-Wars-Poster_4"]
    let moviePosterCellIdentifier = "MoviePostersCell"
    let castCellIdentifier = "CastCell"
    let segueID = "goToWatchlistVC"
    var movieDetailsDataPassed: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegateAndDataSource()
        registerCollectionView()
        registerTableView()
        updateUIMovieDetailsVC()
    }
    
    func updateUIMovieDetailsVC() {
        if let movieDetailsDataPassed = movieDetailsDataPassed {
            displayPassedData(movieNumber: movieDetailsDataPassed)
        } else {
            displayDefaultData()
        }
    }
    
    func displayPassedData(movieNumber: Int) {
        movieNameLabel.text = MovieData().movieNameArray[movieNumber]
        movieNameDetails.text = MovieData().movieDetailsArray[movieNumber]
        movieRateLabel.text = MovieData().movieRateArray[movieNumber]
        movieDescriptionLabel.text = MovieData().movieDescriptionArray[movieNumber]
    }
    
    func displayDefaultData() {
        movieNameLabel.text = MovieData().movieNameArray[0]
        movieNameDetails.text = MovieData().movieDetailsArray[0]
        movieRateLabel.text = MovieData().movieRateArray[0]
        movieDescriptionLabel.text = MovieData().movieDescriptionArray[0]
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func watchlistButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: segueID, sender: self)
    }
    
    
    func setupDelegateAndDataSource() {
        moviePosterCollectionView.delegate = self
        moviePosterCollectionView.dataSource = self
        castTableView.delegate = self
        castTableView.dataSource = self
    }
    
    func registerCollectionView() {
        moviePosterCollectionView.register(UINib.init(nibName: moviePosterCellIdentifier, bundle: nil), forCellWithReuseIdentifier: moviePosterCellIdentifier)
    }
    
    func registerTableView() {
        castTableView.register(UINib.init(nibName: castCellIdentifier, bundle: nil), forCellReuseIdentifier: castCellIdentifier)
    }
    
}


//MARK: - Setup Collection View
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posterImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviePosterCollectionView.dequeueReusableCell(withReuseIdentifier: moviePosterCellIdentifier, for: indexPath) as! MoviePostersCell
        cell.displayPosters(imageNumber: indexPath.item)
        return cell
    }
    
    
    
}


//MARK: - Setup Table View
extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = castTableView.dequeueReusableCell(withIdentifier: castCellIdentifier, for: indexPath) as! CastCell
        cell.displayCastData(castNameNumber: indexPath.row, castDiscriptionNumber: indexPath.row, castImageNumber: indexPath.row)
        return cell
    }
    
    
}
