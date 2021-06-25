//
//  FishesTableViewController.swift
//  FishFinder
//
//  Created by NIKOLAY OSIPOV on 21.06.2021.
//

import UIKit

class FishesTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - Public Properties
    
    var fishes: [Fish] = []
    
    let networkService = Manager()
    let searchController = UISearchController()
    // MARK: - Lige Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Red snapper"
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let aboutFishVC = segue.destination as? AboutFishViewController,
              let index = tableView.indexPathForSelectedRow
        else { return }
        
        aboutFishVC.fish = fishes[index.row]
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fishes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let fish = fishes[indexPath.row]
        
        cell.textLabel?.text = fish.speciesName
        
        return cell
        
    }
    // MARK: - Public Methods
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard var text = searchController.searchBar.text
        else { return }
        text = text.replacingOccurrences(of: " ", with: "-")
        
        let jsonURL = "https:www.fishwatch.gov/api/species/\(text)"
        
        networkService.getFish(jsonUrl: jsonURL) { (result) in
            switch result {
            case .success(let data):
                self.fishes = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let text = searchController.searchBar.text
        else { return }
        
        let jsonURL = "https:www.fishwatch.gov/api/species/\(text)"
        
        networkService.getFish(jsonUrl: jsonURL) { (result) in
            switch result {
            case .success(let data):
                self.fishes = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
