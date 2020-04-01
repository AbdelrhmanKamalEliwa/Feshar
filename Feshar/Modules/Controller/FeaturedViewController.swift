//
//  FeaturedViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    @IBOutlet weak var featuredTableView: UITableView!
    let featuredCellIdentifier = "FeaturedTableViewCell"
    let movieCategoryArray = ["NEW", "TRENDING", "ACTION", "ROMANCE", "COMEDY"]
    public var safeIndexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredTableView.delegate = self
        featuredTableView.dataSource = self
    }
    
    @IBAction func watchlistButtnTapped(_ sender: Any) {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuredTableView.dequeueReusableCell(withIdentifier: featuredCellIdentifier, for: indexPath) as! FeaturedTableViewCell
        cell.updateMovieCategoryTitle(movieCategoryTitleNumber: indexPath.row)
        safeIndexPath = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 232
    }
}
