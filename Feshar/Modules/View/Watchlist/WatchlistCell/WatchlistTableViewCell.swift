//
//  WatchlistTableViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class WatchlistTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    
    
    func displayMovieData(movieName: String, movieDetails: String, movieRate: String, movieImage: String) {
        movieNameLabel.text = movieName
        movieDetailsLabel.text = movieDetails
        movieRateLabel.text = movieRate
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
