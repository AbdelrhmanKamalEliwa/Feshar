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
    let posterImageArray = ["Star-Wars-Poster_2", "Star-Wars-Poster_3", "Star-Wars-Poster_4"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayPosters() {
        posterImage.image = UIImage(named: "Star-Wars-Poster_2")
    }

}
