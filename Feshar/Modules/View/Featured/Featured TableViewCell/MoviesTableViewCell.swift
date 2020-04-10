//
//  FeaturedTableViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    let cellIdentifier = "MoviesCollectionViewCell"
    
    var movieModelPassed = [MovieResults]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        registerCollectionView()
    }
    
    func updateCategory(movieNumber: [MovieResults]) {
        movieModelPassed = movieNumber
        moviesCollectionView.reloadData()
    }
    
    func registerCollectionView() {
        moviesCollectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


//MARK: - Setup Collection View
extension MoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModelPassed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        cell.displayMovieData(movieImage: EndPointRouter.getMoviePoster(posterPath: movieModelPassed[indexPath.item].poster))
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    //        let movieDetailsViewController = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
    //        movieDetailsViewController.movieModelDataPassed = movieModelPassed[indexPath.row]
    //        self.navigationController?.pushViewController(movieDetailsViewController , animated: true)
    //    }
}


extension MoviesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 143, height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -30, left: 15, bottom: 0, right: 0)
    }
}
