//
//  MovieTableViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/30/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    func displayMovieData(movieName: String, movieDetails: String, movieRate: String, movieDescription: String, movieImage: String?) {
        movieNameLabel.text = movieName
        movieDetailsLabel.text = movieDetails
        movieRateLabel.text = movieRate
        movieDescriptionLabel.text = movieDescription
        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
