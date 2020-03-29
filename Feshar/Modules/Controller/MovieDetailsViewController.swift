//
//  MovieDetailsViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var moviePosterCollectionView: UICollectionView!
    let posterImageArray = ["Star-Wars-Poster_2", "Star-Wars-Poster_3", "Star-Wars-Poster_4"]
    let cellIdentifier = "MoviePostersCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        setupDelegateAndDataSource()
        
    }
    
    func setupDelegateAndDataSource() {
        moviePosterCollectionView.delegate = self
        moviePosterCollectionView.dataSource = self
    }
    
    func registerCollectionView() {
        moviePosterCollectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
}


//MARK: - Setup Collection View
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posterImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviePosterCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoviePostersCell
        cell.displayPosters()
        return cell
    }
}
