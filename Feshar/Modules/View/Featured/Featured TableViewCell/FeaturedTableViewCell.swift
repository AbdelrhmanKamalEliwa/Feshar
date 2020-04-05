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
    
    var movieModelPassed = [MovieModel]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        registerCollectionView()
    }
    
    func updateMovieCategoryTitle(movieNumber: [MovieModel]) {
        movieModelPassed = movieNumber
        featuredCollectionView.reloadData()
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
        return movieModelPassed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FeaturedCollectionViewCell
        
        cell.movieImageView.image = UIImage(named: movieModelPassed[indexPath.item].moviePoster)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let movieDetailsViewController = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
//        movieDetailsViewController.movieModelDataPassed = movieModelPassed[indexPath.row]
//        self.navigationController?.pushViewController(movieDetailsViewController , animated: true)
//    }
}


extension FeaturedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 143, height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -30, left: 15, bottom: 0, right: 0)
    }
}
