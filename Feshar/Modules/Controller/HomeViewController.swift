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
    
    var movieModelData = movieModel
    var filteredMovies: [MovieModel] = []
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavBar()
        setupDelegateAndDataSource()
        registerCollectionView()
        registerTableView()
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
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
    
    func displayShareSheet() {
        let alertController = UIAlertController(title: "Action Sheet", message: "What would you like to do?", preferredStyle: .actionSheet)
        let shareOnFacebook = UIAlertAction(title: "Share on Facebook", style: .default, handler: nil)
        let shareOnTwitter = UIAlertAction(title: "Share on Twitter", style: .default, handler: { (action) -> Void in
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(shareOnFacebook)
        alertController.addAction(shareOnTwitter)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }
    
    func displaySharing() {
        let items: [Any] = ["my movie", UIImage(named: "logo")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
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
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(myLeftSideBarButtonItemTapped(_:)))
        navigationItem.leftBarButtonItem = backBarButton
        let featuredBarButton = UIBarButtonItem(image: UIImage(systemName: "wand.and.stars.inverse"), style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = featuredBarButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender: UIBarButtonItem!)
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let watchlistViewController = storyboard.instantiateViewController(identifier: "WatchlistViewController") as! WatchlistViewController
        self.navigationController?.pushViewController(watchlistViewController, animated: true)
    }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender: UIBarButtonItem!)
    {
        self.dismiss(animated: true, completion: nil)
    }
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
        if indexPath.item == 0 {
            movieModelData = movieModel
            movieTableView.reloadData()
        } else {
            var safeMovieModel: [MovieModel] = []
            for movie in movieModel {
                if movie.movieCategoryType.lowercased() == selectedCell.movieTypeTitleLabel.text?.lowercased() {
                    safeMovieModel.append(movie)
                }
                movieModelData = [MovieModel]()
                movieModelData = safeMovieModel
            }
            movieTableView.reloadData()
        }
        
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
            return movieModelData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieTableViewCell
        if searching {
            cell.displayMovieData(movieName: filteredMovies[indexPath.row].movieName, movieDetails: filteredMovies[indexPath.row].movieDetails, movieRate: filteredMovies[indexPath.row].movieRate, movieDescription: filteredMovies[indexPath.row].movieDescription, movieImage: filteredMovies[indexPath.row].moviePoster)
            return cell
        } else {
            cell.displayMovieData(movieName: movieModelData[indexPath.row].movieName, movieDetails: movieModelData[indexPath.row].movieDetails, movieRate: movieModelData[indexPath.row].movieRate, movieDescription: movieModelData[indexPath.row].movieDescription, movieImage: movieModelData[indexPath.row].moviePoster)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let movieDetailsViewController = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        if searching {
            movieDetailsViewController.movieModelDataPassed = filteredMovies[indexPath.row]
        } else {
            movieDetailsViewController.movieModelDataPassed = movieModelData[indexPath.row]
        }
        self.navigationController?.pushViewController(movieDetailsViewController , animated: true)
    }
    
    
    //    swipe to left
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title:  "Share", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if self.searching {
                let items: [Any] = [self.filteredMovies[indexPath.row].movieName, self.filteredMovies[indexPath.row].moviePoster]
                let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                self.present(activityViewController, animated: true)
            } else {
                let items: [Any] = [self.movieModelData[indexPath.row].movieName, self.movieModelData[indexPath.row].moviePoster]
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
                movieModel[movieModel.firstIndex(where: {$0.movieName.lowercased() == self.filteredMovies[indexPath.row].movieName.lowercased()})!].isFavorite = true
            } else {
                movieModel[movieModel.firstIndex(where: {$0.movieName.lowercased() == self.movieModelData[indexPath.row].movieName.lowercased()})!].isFavorite = true
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
        filteredMovies = movieModel.filter {$0.movieName.lowercased().prefix(searchText.count) == searchText.lowercased()}
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
