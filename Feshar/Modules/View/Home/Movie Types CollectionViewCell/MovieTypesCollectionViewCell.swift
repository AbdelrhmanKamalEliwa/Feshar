//
//  MovieTypesCollectionViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/30/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MovieTypesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTypeButton: UIButton!
    let movieTypeButtonNameArray = ["Romance", "Action", "Comedy"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setMovieTypeButtonName(nameNumber: Int) {
//        movieTypeButton.text = movieTypeButtonNameArray[nameNumber]
        
    }

    @IBAction func moveTypeButtonTapped(_ sender: Any) {
    }
}
