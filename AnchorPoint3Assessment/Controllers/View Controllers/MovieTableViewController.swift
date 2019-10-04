//
//  MovieTableViewController.swift
//  AnchorPoint3Assessment
//
//  Created by Josh Sparks on 10/4/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieSearchResults: [MovieSearch] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = 150
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        MovieController.fetchMovie(searchText: searchText) { (results) in
            self.movieSearchResults = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchBar.text = ""
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSearchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! ResultTableViewCell
        
        let searchResultItem = movieSearchResults[indexPath.row]
        cell.movieItem = searchResultItem
        
        return cell
    }
} // end of class
