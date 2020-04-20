//
//  FeaturedViewController.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 3/31/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    let cellIdentifier = "MoviesCollectionViewCell"
    var selectedSegment = 0
    var moviesArray = [MovieResults]()
    var tvShowsArray = [TVShowResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        setupCustomNavBar()
        registerCollectionView()
        getMoviesData()
        getTVShowsData()
    }
    
    @IBAction func segmentedControlButtonTapped(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            selectedSegment = 0
            featuredCollectionView.reloadData()
        } else if segmentedControl.selectedSegmentIndex == 1 {
            selectedSegment = 1
            featuredCollectionView.reloadData()
        }
    }
    
    func logout() {
        guard let validSessionId = sessionID else { return }
        LogoutNetworkManager().logout(sessionId: validSessionId) { (response: LogoutResponse?) in
            guard let safeResponse = response else { return }
            if safeResponse.success {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    sessionID = nil
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
extension FeaturedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if featuredCollectionView.panGestureRecognizer.translation(in: self.view).y < 0 {
            self.segmentedControl.isHidden = true
        } else {
        self.segmentedControl.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedSegment == 0 { return moviesArray.count }
        return tvShowsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        if selectedSegment == 0 {
            cell.displayMovieData(movieImage: EndPointRouter.getMoviePoster(posterPath: moviesArray[indexPath.item].poster))
        } else {
            cell.displayMovieData(movieImage: EndPointRouter.getMoviePoster(posterPath: tvShowsArray[indexPath.item].poster!))
        }
        
        return cell
    }
    
    func registerCollectionView() {
        featuredCollectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = featuredCollectionView.frame.width / 3 - 1
        return CGSize(width: width, height: width + 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1.0
    }
    
}



//MARK: - Networking
extension FeaturedViewController {
    
    func getMoviesData() {
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getMovies, httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<MovieModel>) in
            switch result {
                
            case .success(let data):
                self.moviesArray = data.results
                DispatchQueue.main.async {
                    self.featuredCollectionView.reloadData()
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
    
    func getTVShowsData() {
        let networkManager = NetworkManager()
        let _ = networkManager.request(url: EndPointRouter.getTVShows, httpMethod: .get, parameters: nil, headers: nil) { (result: APIResult<TVShowModel>) in
            switch result {
                
            case .success(let data):
                self.tvShowsArray = data.results
                DispatchQueue.main.async {
                    self.featuredCollectionView.reloadData()
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
