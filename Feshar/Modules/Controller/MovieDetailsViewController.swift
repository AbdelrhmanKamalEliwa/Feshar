//
//  MovieDetailsViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieNameDetails: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var moviePosterCollectionView: UICollectionView!
    
    let moviePosterCellIdentifier = "MoviePostersCell"
    let castCellIdentifier = "CastCell"
    
    var movieDetailsScreenObject: MovieDetailsScreen?
    var movieIdPassed: Int?
    var moviePosters = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        setupDelegateAndDataSource()
        registerCollectionView()
        registerTableView()
        fetchData()
        
        //        displayWatchListButton()
    }
//    *Need to replace movieModelDataPassed with movieDetailsScreenObject*
    //    func displayWatchListButton() {
    //        if movieModelDataPassed?.isFavorite == true {
    //            watchListButton.setTitle("REMOVE FROM WATCHLIST", for: .normal)
    //            watchListButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
    //        } else if movieModelDataPassed?.isFavorite == false {
    //            watchListButton.setTitle("ADD TO WATCHLIST", for: .normal)
    //        }
    //    }
    
    @IBAction func watchListButtonTapped(_ sender: Any) {
//        *Need to replace movieModelDataPassed with movieDetailsScreenObject*
        //        if movieModelDataPassed?.isFavorite == true {
        ////            for movie in movieModel {
        ////                if movie.isFavorite == movieModelDataPassed?.isFavorite {
        ////                    movieModel[movieModel.firstIndex(where: {$0.movieName.lowercased() == self.movieModelDataPassed!.movieName.lowercased()})!].isFavorite = false
        ////                }
        ////            }
        //            watchListButton.setTitle("ADD TO WATCHLIST", for: .normal)
        //            watchListButton.backgroundColor = #colorLiteral(red: 0.9276102185, green: 0.3129869699, blue: 0.2666297853, alpha: 1)
        //        } else if movieModelDataPassed?.isFavorite == false {
        ////            for movie in movieModel {
        ////                if movie.isFavorite == movieModelDataPassed?.isFavorite {
        ////                    movieModel[movieModel.firstIndex(where: {$0.movieName.lowercased() == self.movieModelDataPassed!.movieName.lowercased()})!].isFavorite = false
        ////                }
        ////            }
        //            watchListButton.setTitle("REMOVE FROM WATCHLIST", for: .normal)
        //            watchListButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        //        }
    }
    
    func displayPassedData() {
        movieNameLabel.text = movieDetailsScreenObject!.title
        movieNameDetails.text = movieDetailsScreenObject!.title
        movieRateLabel.text = String(movieDetailsScreenObject!.imdbRate)
        movieDescriptionLabel.text = movieDetailsScreenObject!.description
        moviePosters = [EndPointRouter.getMoviePoster(posterPath: movieDetailsScreenObject!.poster)]
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


//MARK: - Networking
extension MovieDetailsViewController {
    func fetchData() {
        if let safeMovieId = movieIdPassed {
            let networkManager = NetworkManager()
            let _ = networkManager.request(url: EndPointRouter.getMovieDetails(movieId: String(safeMovieId)), httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<MovieDetailsScreen>) in
                switch result {
                case .success(let data):
                    self.movieDetailsScreenObject = data
                    DispatchQueue.main.async {
                        self.displayPassedData()
                        self.moviePosterCollectionView.reloadData()
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
        moviePosters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviePosterCollectionView.dequeueReusableCell(withReuseIdentifier: moviePosterCellIdentifier, for: indexPath) as! MoviePostersCell
        cell.displayMoviePosters(moviePoster: moviePosters[indexPath.item])
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
