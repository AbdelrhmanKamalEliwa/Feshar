//
//  FeaturedCollectionViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    
    func displayMovieData(movieImage: String?) {
        if movieImage != nil {
            guard let url = URL(string: movieImage!) else { return }
            movieImageView.kf.indicatorType = .activity
            movieImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                switch result {
                    case .success(let image):
                        self.movieImageView.image = image.image
                    case .failure(_):
                        self.movieImageView.image = UIImage(named: "default-movie-image")?.imageFlippedForRightToLeftLayoutDirection()
                        return
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
