//
//  MovieTableViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/30/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    func displayMovieData(movieName: String, movieDetails: String, movieType: String, movieRate: String, movieDescription: String, movieImage: String) {
        movieNameLabel.text = movieName
        movieDetailsLabel.text = movieDetails
        movieTypeLabel.text = movieType
        movieRateLabel.text = movieRate
        movieDescriptionLabel.text = movieDescription
        movieImageView.image = UIImage(named: movieImage)
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
