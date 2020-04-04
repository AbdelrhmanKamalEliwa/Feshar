//
//  ProfileInfoTableViewCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/3/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellDataLabel: UILabel!
    
    func displayCell(cellTitle: String, cellData: String) {
        cellTitleLabel.text = cellTitle
        cellDataLabel.text = cellData
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
