//
//  MRFMovieListTableViewController.swift
//  MovieSearchOBJC
//
//  Created by Michael Flowers on 10/11/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MRFMovieListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //MARK: - SearchBar Delegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let title = searchBar.text, !title.isEmpty else {
            print("Error getting text out of searchbar")
            return
        }
        
        MRFMovieController.sharedInstance().fetchMovieSearchTerm(title) { (success) in
            if success {
                print("Called the fetch movie function in table view controller")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MRFMovieController.sharedInstance().movies.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MRFMovieCellTableViewCell
        let movie = MRFMovieController.sharedInstance().movies[indexPath.row]
        
        MRFMovieController.sharedInstance().fetchPostImage(with: movie) { (image) in
            guard let returnedImage = image else {
                print("Error getting poster image from the server: \(#function)")
                return
            }
            cell.movie = movie
            cell.posterImage = returnedImage
        }
     
     return cell
     }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
