//
//  MovieDetailsViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieNameDetails: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var moviePosterCollectionView: UICollectionView!

    let moviePosterCellIdentifier = "MoviePostersCell"
    let castCellIdentifier = "CastCell"
    
    var movieModelDataPassed: MovieModel?
    var movieImages = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        setupDelegateAndDataSource()
        registerCollectionView()
        registerTableView()
        displayPassedData()
    }
    
    func displayPassedData() {
        movieNameLabel.text = movieModelDataPassed?.movieName
        movieNameDetails.text = movieModelDataPassed?.movieDetails
        movieRateLabel.text = movieModelDataPassed?.movieRate
        movieDescriptionLabel.text = movieModelDataPassed?.movieDescription
        movieImages = movieModelDataPassed?.movieImages ?? [" "]
    }
    
    
    func setupDelegateAndDataSource() {
        moviePosterCollectionView.delegate = self
        moviePosterCollectionView.dataSource = self
        castTableView.delegate = self
        castTableView.dataSource = self
    }
    
    func registerCollectionView() {
        moviePosterCollectionView.register(UINib.init(nibName: moviePosterCellIdentifier, bundle: nil), forCellWithReuseIdentifier: moviePosterCellIdentifier)
    }
    
    func registerTableView() {
        castTableView.register(UINib.init(nibName: castCellIdentifier, bundle: nil), forCellReuseIdentifier: castCellIdentifier)
    }
    
}


//MARK: - Setup Custome Nav-Bar
extension MovieDetailsViewController {
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
        let settingBarButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = settingBarButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!)
    {
        print("myRightSideBarButtonItemTapped")
    }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!)
    {
        self.navigationController?.popViewController(animated: true)
    }
}



//MARK: - Setup Collection View
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviePosterCollectionView.dequeueReusableCell(withReuseIdentifier: moviePosterCellIdentifier, for: indexPath) as! MoviePostersCell
        cell.posterImage.image = UIImage(named: movieImages[indexPath.item])
        
        return cell
    }
    
    
    
}


//MARK: - Setup Table View
extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = castTableView.dequeueReusableCell(withIdentifier: castCellIdentifier, for: indexPath) as! CastCell
        cell.displayCastData(castNameNumber: indexPath.row, castDiscriptionNumber: indexPath.row, castImageNumber: indexPath.row)
        return cell
    }
    
    
}
