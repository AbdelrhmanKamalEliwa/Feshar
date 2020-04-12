//
//  HomeViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/30/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var movieTypeCollectionView: UICollectionView!
    let movieTypeIdentifier = "MovieTypesCollectionViewCell"
    let movieCellIdentifier = "MovieTableViewCell"
    let movieTypeButtonNameArray = ["All Movies", "Romance", "Action", "Comedy", "Drama"]
    let searchBarIsHidden = true
    var movieHomeScreenArray = [MovieResults]()
    var allMoviesArray = [MovieResults]()
    var filteredMovies: [SearchMovieResults] = []
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        setupDelegateAndDataSource()
        registerCollectionView()
        registerTableView()
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        fetchMoviesData()
        WatchlistNetworkManager().fetchWatchlistMoviesData { (data: WatchlistMovieModel?) in
            if let data = data {
                actualWatchlistMoviesArray = data.results
//                print(actualWatchlistMoviesArray.count)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = movieTableView.indexPathForSelectedRow {
            movieTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    func setupDelegateAndDataSource() {
        movieTypeCollectionView.delegate = self
        movieTypeCollectionView.dataSource = self
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
    
    func registerCollectionView() {
        movieTypeCollectionView.register(UINib.init(nibName: movieTypeIdentifier, bundle: nil), forCellWithReuseIdentifier: movieTypeIdentifier)
    }
    
    func registerTableView() {
        movieTableView.register(UINib.init(nibName: movieCellIdentifier, bundle: nil), forCellReuseIdentifier: movieCellIdentifier)
    }
    
    func logout() {
        if let sessionId = sessionID {
            LogoutNetworkManager().logout(sessionId: sessionId) { (response: LogoutResponse?) in
//                print(response)
                if let response = response {
                    if response.success {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                            sessionID = nil
                        }
                    }
                }
            }
        }
    }
    
    func goToWatchlistViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let watchlistViewController = storyboard.instantiateViewController(identifier: "WatchlistViewController") as! WatchlistViewController
        self.navigationController?.pushViewController(watchlistViewController, animated: true)
    }
    
}



//MARK: - Setup Custome Nav-Bar
extension HomeViewController {
    func setupCustomNavBar() {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.tintColor = UIColor.gray
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 85, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
        let backBarButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(myLeftSideBarButtonItemTapped(_:)))
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.08921027929, blue: 0.1636223793, alpha: 1)
        let featuredBarButton = UIBarButtonItem(image: UIImage(systemName: "wand.and.stars.inverse"), style: .done, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = featuredBarButton
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6209790111, green: 0.3204901814, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!) { goToWatchlistViewController() }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!) { logout() }
}



//MARK: - Setup Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieTypeButtonNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieTypeCollectionView.dequeueReusableCell(withReuseIdentifier: movieTypeIdentifier, for: indexPath) as! MovieTypesCollectionViewCell
        cell.movieTypeTitleLabel.text = movieTypeButtonNameArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searching = false
        searchBar.searchTextField.text = ""
        searchBar.searchTextField.resignFirstResponder()
        let selectedCell = movieTypeCollectionView.cellForItem(at: indexPath) as! MovieTypesCollectionViewCell
        selectedCell.layer.backgroundColor = #colorLiteral(red: 0.9373905063, green: 0.2940055132, blue: 0.2428910136, alpha: 1)
        selectedCell.movieTypeTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        var safeMovieModel: [MovieResults] = []
        print(safeMovieModel.count)
        for movie in allMoviesArray {
            if movie.category.contains(28) && (selectedCell.movieTypeTitleLabel.text!.lowercased() == "action"){
                safeMovieModel.append(movie)
            } else if movie.category.contains(35) && (selectedCell.movieTypeTitleLabel.text!.lowercased() == "comedy"){
                safeMovieModel.append(movie)
            } else if movie.category.contains(18) && selectedCell.movieTypeTitleLabel.text?.lowercased() == "drama"{
                safeMovieModel.append(movie)
            } else if movie.category.contains(10749) && selectedCell.movieTypeTitleLabel.text?.lowercased() == "romance"{
                safeMovieModel.append(movie)
            } else if selectedCell.movieTypeTitleLabel.text!.lowercased() == "all movies" {
                safeMovieModel = allMoviesArray
            }
        }

        movieHomeScreenArray = safeMovieModel
        movieTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //        force unwrapping crashed? whyyyy!!!
        let selectedCell = movieTypeCollectionView.cellForItem(at: indexPath) as? MovieTypesCollectionViewCell
        selectedCell?.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        selectedCell?.movieTypeTitleLabel.textColor = #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    }
}



//MARK: - Setup Table View
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredMovies.count
        } else {
            return movieHomeScreenArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieTableViewCell
        if searching {
            cell.displayMovieData(movieName: filteredMovies[indexPath.row].title, movieDetails: filteredMovies[indexPath.row].title, movieRate: "\(filteredMovies[indexPath.row].imdbRate)", movieDescription: filteredMovies[indexPath.row].description, movieImage: EndPointRouter.getMoviePoster(posterPath: filteredMovies[indexPath.row].poster ?? ""))
            return cell
        } else {
            cell.displayMovieData(movieName: movieHomeScreenArray[indexPath.row].title, movieDetails: movieHomeScreenArray[indexPath.row].title, movieRate: String(movieHomeScreenArray[indexPath.row].imdbRate), movieDescription: movieHomeScreenArray[indexPath.row].description, movieImage: EndPointRouter.getMoviePoster(posterPath: movieHomeScreenArray[indexPath.row].poster))
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let movieDetailsViewController = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        if searching {
            movieDetailsViewController.movieIdPassed = filteredMovies[indexPath.row].id
        } else {
            movieDetailsViewController.movieIdPassed = movieHomeScreenArray[indexPath.row].id
        }
        self.navigationController?.pushViewController(movieDetailsViewController , animated: true)
    }
    
    
    //    swipe to left
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title:  "Share", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if self.searching {
                let items: [Any] = [self.filteredMovies[indexPath.row].title, self.filteredMovies[indexPath.row].title]
                let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                self.present(activityViewController, animated: true)
            } else {
                let items: [Any] = [self.movieHomeScreenArray[indexPath.row].title, self.movieHomeScreenArray[indexPath.row].title]
                let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                self.present(activityViewController, animated: true)
            }
            success(true)
        })
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        shareAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
    //    swipe to right
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title:  "Add to Wishlist", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            if self.searching {
                for movie in actualWatchlistMoviesArray {
                    if movie.id == self.filteredMovies[indexPath.row].id {
                        let alert = UIAlertController(title: "Error" , message: "Movie Already in Watchlist", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        WatchlistNetworkManager().fetchAddToWatchlistMovies(mediaId: self.filteredMovies[indexPath.row].id) { (addToWatchlistResponse: AddToWatchlistResponse?) in
                            DispatchQueue.main.async {
                                if let addToWatchlistResponse = addToWatchlistResponse {
                                    let alert = UIAlertController(title: addToWatchlistResponse.statusMessage , message: "Movie Added to Watchlist", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
            } else {
                for movie in actualWatchlistMoviesArray {
                    if movie.id == self.movieHomeScreenArray[indexPath.row].id {
                        let alert = UIAlertController(title: "Error" , message: "Movie Already in Watchlist", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        WatchlistNetworkManager().fetchAddToWatchlistMovies(mediaId: self.movieHomeScreenArray[indexPath.row].id) { (addToWatchlistResponse: AddToWatchlistResponse?) in
                            DispatchQueue.main.async {
                                if let addToWatchlistResponse = addToWatchlistResponse {
                                    let alert = UIAlertController(title: addToWatchlistResponse.statusMessage , message: "Movie Added to Watchlist", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
            }
            
            success(true)
        })
        addAction.image = UIImage(systemName: "wand.and.stars.inverse")
        addAction.backgroundColor = .systemIndigo
        return UISwipeActionsConfiguration(actions: [addAction])
    }
    
}


//MARK: - Setup Search Bar
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchSearchOnMoviesData(textSearch: searchText.lowercased())
        searching = true
        if searchText.isEmpty {
            searching = false
        }
        movieTableView.reloadData()
    }
    
}


//MARK: - Text Field Delegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


//MARK: - Networking
extension HomeViewController {
    func fetchMoviesData() {
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getMovies, httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<MovieModel>) in
            switch result {
                
            case .success(let data):
                self.movieHomeScreenArray = data.results
                self.allMoviesArray = data.results
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                    allMovies = data.results
                }
            case .failure(let error):
                if let error = error {
                    print(error)
                }
            case .decodingFailure(let error):
                if let error = error {
                    print(error)
                }
            case .badRequest(let error):
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    
    func fetchSearchOnMoviesData(textSearch: String) {
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.searchOnMovies(movieName: textSearch), httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<SearchMovieModel>) in
            switch result {
                
            case .success(let data):
                self.filteredMovies = data.results
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            case .failure(let error):
                if let error = error {
                    print(error)
                }
            case .decodingFailure(let error):
                
                if let error = error {
                    print(error)
                }
            case .badRequest(let error):
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
