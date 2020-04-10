//
//  TVShowsCollectionViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/10/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class TVShowsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tvShowImageView: UIImageView!
    
    func displayMovieData(movieImage: String?) {
        if movieImage != nil {
            guard let url = URL(string: movieImage!) else { return }
            tvShowImageView.kf.indicatorType = .activity
            tvShowImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                switch result {
                    case .success(let image):
                        self.tvShowImageView.image = image.image
                    case .failure(_):
                        self.tvShowImageView.image = UIImage(named: "default-movie-image")?.imageFlippedForRightToLeftLayoutDirection()
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
