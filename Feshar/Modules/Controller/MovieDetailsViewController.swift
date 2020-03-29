//
//  MovieDetailsViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var moviePosterCollectionView: UICollectionView!
    let posterImageArray = ["Star-Wars-Poster_2", "Star-Wars-Poster_3", "Star-Wars-Poster_4"]
    let moviePosterCellIdentifier = "MoviePostersCell"
    let castCellIdentifier = "CastCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegateAndDataSource()
        registerCollectionView()
        registerTableView()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
