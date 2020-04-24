//
//  MovieDetailsViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private weak var movieTableViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet private weak var watchListButton: UIButton!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieNameDetails: UILabel!
    @IBOutlet private weak var movieRateLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var castTableView: UITableView!
    @IBOutlet private weak var moviePosterCollectionView: UICollectionView!
    fileprivate let moviePosterCellIdentifier = "MoviePostersCell"
    fileprivate let castCellIdentifier = "CastCell"
    fileprivate var movieDetailsScreenObject: MovieDetailsScreen?
    var movieIdPassed: Int?
    fileprivate var details = ""
    fileprivate var moviePosters = [Posters]()
    fileprivate var movieCredits = [Cast]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        setupDelegateAndDataSource()
        registerCollectionView()
        registerTableView()
        fetchData()
        fetchMovieCredits()
        fetchMoviePosters()
        //        castTableView.rowHeight = UITableView.automaticDimension
        //        castTableView.estimatedRowHeight = 600
    }
    
    func checkIfMovieInWatchlist() {
        for movie in actualWatchlistMoviesArray {
            if movie.id == movieDetailsScreenObject!.id {
                watchListButton.setTitle("REMOVE FROM WATCHLIST", for: .normal)
                watchListButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
            }
        }
    }
    
    @IBAction func watchListButtonTapped(_ sender: Any) {
        
        for movie in actualWatchlistMoviesArray {
            if movie.id == movieDetailsScreenObject!.id {
                let alert = UIAlertController(title: "Error" , message: "Movie Already in Watchlist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                WatchlistNetworkManager().fetchAddToWatchlistMovies(mediaId: movieDetailsScreenObject!.id) { [weak self] (addToWatchlistResponse: AddToWatchlistResponse?) in
                    DispatchQueue.main.async {
                        if let addToWatchlistResponse = addToWatchlistResponse {
                            let alert = UIAlertController(title: addToWatchlistResponse.statusMessage , message: "Movie Added to Watchlist", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self?.present(alert, animated: true, completion: nil)
                            self?.watchListButton.setTitle("REMOVE FROM WATCHLIST", for: .normal)
                            self?.watchListButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
                        }
                    }
                }
            }
        }
    }
    
    func displayPassedData() {
        for genre in movieDetailsScreenObject!.genres {
            details = details + genre.name + " | "
        }
        details.removeLast(3)
        movieNameLabel.text = movieDetailsScreenObject!.title
        movieNameDetails.text = details
        movieRateLabel.text = String(movieDetailsScreenObject!.imdbRate)
        movieDescriptionLabel.text = movieDetailsScreenObject!.description
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
    
    func backToPreviousViewController() { self.navigationController?.popViewController(animated: true) }
    
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
                        self.checkIfMovieInWatchlist()
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
    
    func fetchMoviePosters() {
        guard let safeMovieId = movieIdPassed else { return }
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getAllPostersMovie(movieId: String(safeMovieId)), httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<MoviePostersModel>) in
            switch result {
            case .success(let data):
                self.moviePosters = data.posters
                DispatchQueue.main.async {
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
    
    func fetchMovieCredits() {
        guard let safeMovieId = movieIdPassed else { return }
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getMovieCredits(movieId: String(safeMovieId)), httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<MovieCredits>) in
            switch result {
            case .success(let data):
                self.movieCredits = data.cast
                DispatchQueue.main.async {
                    self.castTableView.reloadData()
                    self.updateHeightConstrainOfTableView(numberOfCells: self.movieCredits.count)
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
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!) {
        print("myRightSideBarButtonItemTapped")
    }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!) { backToPreviousViewController() }
}



//MARK: - Setup Collection View
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviePosters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviePosterCollectionView.dequeueReusableCell(withReuseIdentifier: moviePosterCellIdentifier, for: indexPath) as! MoviePostersCell
        cell.displayMoviePosters(moviePoster: EndPointRouter.getMoviePoster(posterPath: moviePosters[indexPath.item].posterPath ?? ""))
        return cell
    }
    
    
    
}


//MARK: - Setup Table View
extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCredits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = castTableView.dequeueReusableCell(withIdentifier: castCellIdentifier, for: indexPath) as! CastCell
        cell.displayCastData(castName: movieCredits[indexPath.row].name, castDiscription: movieCredits[indexPath.row].id, castImage: EndPointRouter.getMoviePoster(posterPath: movieCredits[indexPath.row].profileImage ?? ""))
        return cell
    }
    
    func updateHeightConstrainOfTableView(numberOfCells: Int) {
        movieTableViewHeightConstrain.constant = CGFloat(numberOfCells * 106)
    }
    
}
