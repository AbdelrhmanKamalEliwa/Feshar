//
//  FeaturedTableViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieCategoryTitleLabel: UILabel!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    let cellIdentifier = "FeaturedCollectionViewCell"
    let movieCategoryArray = ["NEW", "TRENDING", "ACTION", "ROMANCE", "COMEDY"]
    var movieCategoryNumber = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        registerCollectionView()
    }
    
    func updateMovieCategoryTitle(movieCategoryTitleNumber: Int) {
        movieCategoryTitleLabel.text = movieCategoryArray[movieCategoryTitleNumber]
        movieCategoryNumber = movieCategoryTitleNumber
    }
    
    func registerCollectionView() {
        featuredCollectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FeaturedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCategoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FeaturedCollectionViewCell
        if movieCategoryNumber == 0 {
            cell.movieImageView.image = UIImage(named: MovieCategories().newMoviesArray[indexPath.item])
        } else if movieCategoryNumber == 1 {
            cell.movieImageView.image = UIImage(named: MovieCategories().trendingMoviesArray[indexPath.item])
        } else if movieCategoryNumber == 2 {
            cell.movieImageView.image = UIImage(named: MovieCategories().actionMoviesArray[indexPath.item])
        } else if movieCategoryNumber == 3 {
            cell.movieImageView.image = UIImage(named: MovieCategories().romanceMoviesArray[indexPath.item])
        } else if movieCategoryNumber == 4 {
            cell.movieImageView.image = UIImage(named: MovieCategories().comedyMoviesArray[indexPath.item])
        }
                
        return cell
    }
    
    
}


extension FeaturedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 143, height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -30, left: 15, bottom: 0, right: 0)
    }
}
