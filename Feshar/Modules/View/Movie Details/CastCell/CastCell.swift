//
//  CastCell.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit
import Kingfisher

class CastCell: UITableViewCell {
    
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var castDescriptionLabel: UILabel!
    
    func displayCastData(castName: String, castDiscription: Int?, castImage: String?) {
        castNameLabel.text = castName
        
        if castImage != nil {
            guard let url = URL(string: castImage!) else { return }
            castImageView.kf.indicatorType = .activity
            castImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                switch result {
                case .success(let image):
                    self.castImageView.image = image.image
                case .failure(_):
                    self.castImageView.image = UIImage(systemName: "person.fill")?.imageFlippedForRightToLeftLayoutDirection()
                    return
                }
            }
        }
        
        guard let safeId = castDiscription else { return }
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getBiographyOfCast(id: String(safeId)), httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<PersonModel>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.castDescriptionLabel.text = data.biography
                }
            case .failure(let error):
                if let error = error { print(error) }
            case .decodingFailure(let error):
                if let error = error { print(error) }
            case .badRequest(let error):
                if let error = error { print(error) }
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        castImageView.layer.cornerRadius = castImageView.frame.height / 2
    }
    
}
