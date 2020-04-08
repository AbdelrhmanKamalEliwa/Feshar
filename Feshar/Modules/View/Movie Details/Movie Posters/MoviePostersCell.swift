//
//  MoviePostersCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MoviePostersCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    func displayMoviePosters(moviePoster: String?) {
        if moviePoster != nil {
            guard let url = URL(string: moviePoster!) else { return }
            posterImage.kf.indicatorType = .activity
            posterImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                switch result {
                    case .success(let image):
                        self.posterImage.image = image.image
                    case .failure(_):
                        self.posterImage.image = UIImage(named: "default-movie-image")?.imageFlippedForRightToLeftLayoutDirection()
                        return
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func displayPosters(imageNumber: Int) {
//        posterImage.image = UIImage(named: posterImageArray[imageNumber])
//    }
    
}
