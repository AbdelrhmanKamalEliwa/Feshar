//
//  CastCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class CastCell: UITableViewCell {
    let castNameArray = ["Annie Hall", "Jodee Furrow", "Karl Nyland"]
    let castDiscriptionArray = ["Sometext Sometext Sometext Sometext", "Sometext Sometext Sometext Sometext", "Sometext Sometext Sometext Sometext"]
    let castImageArray = ["Star-Wars-Poster_2", "Star-Wars-Poster_3", "Star-Wars-Poster_4"]
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var castDescriptionLabel: UILabel!
    
    func displayCastData(castNameNumber: Int, castDiscriptionNumber: Int, castImageNumber: Int) {
        castNameLabel.text = castNameArray[castNameNumber]
        castDescriptionLabel.text = castDiscriptionArray[castDiscriptionNumber]
        castImageView.image = UIImage(named: castImageArray[castImageNumber])
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
