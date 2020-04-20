//
//  FeaturedVC.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/19/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class FeaturedVC: UIViewController {
    
    var moviesArray = [MovieResults]()
    var tvShowsArray = [TVShowResults]()
    let cellIdentifier = "MoviesCollectionViewCell"
    var selectedSegment = 0
//    var dataToBeDisplay = []()
    
    @IBOutlet weak var segmentedControlLabel: UISegmentedControl!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        registerCollectionView()
        getMoviesData()
        getTVShowsData()
    }
    
    @IBAction func segmentedControlButtonTapped(_ sender: UISegmentedControl) {
        if segmentedControlLabel.selectedSegmentIndex == 0 {
            selectedSegment = 0
            featuredCollectionView.reloadData()
        } else if segmentedControlLabel.selectedSegmentIndex == 1 {
            selectedSegment = 1
            featuredCollectionView.reloadData()
        }
    }
    

}


extension FeaturedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedSegment == 0 {
            return moviesArray.count
            
        }
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
extension FeaturedVC {
    
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
