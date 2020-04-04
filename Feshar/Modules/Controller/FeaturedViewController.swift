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
    var movieModelData = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        featuredTableView.delegate = self
        featuredTableView.dataSource = self
    }
    
    
    @IBAction func watchlistButtnTapped(_ sender: Any) {
    }
    
    
}


//MARK: - Setup Custome Nav-Bar
extension FeaturedViewController {
    func setupCustomNavBar() {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.tintColor = UIColor.gray
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 85, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(myLeftSideBarButtonItemTapped(_:)))
        navigationItem.leftBarButtonItem = backBarButton
        let featuredBarButton = UIBarButtonItem(image: UIImage(systemName: "wand.and.stars.inverse"), style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = featuredBarButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!)
    {
        print("myRightSideBarButtonItemTapped")
    }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!)
    {
        self.dismiss(animated: true, completion: nil)
    }
}



//MARK: - Setup Table View
extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuredTableView.dequeueReusableCell(withIdentifier: featuredCellIdentifier, for: indexPath) as! FeaturedTableViewCell
        var safeMovieModel: [MovieModel] = []
        for movie in movieModel {
            if movie.movieCategoryType.lowercased() == movieCategoryArray[indexPath.row].lowercased() {
                safeMovieModel.append(movie)
            }
        }
        movieModelData = safeMovieModel
        cell.movieCategoryTitleLabel.text = movieCategoryArray[indexPath.row]
        cell.updateMovieCategoryTitle(movieNumber: movieModelData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 232
    }
}
