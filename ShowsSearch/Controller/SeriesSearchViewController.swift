//
//  SeriesSearchViewController.swift
//  ShowsSearch
//
//  Created by Marco Tullio Braga Filho on 17/06/25.
//

import UIKit
import SDWebImage

class SeriesSearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    weak var searchBar: UISearchBar?
    weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        createSearchBar()
        createTableView()
        
        navigationItem.title = "Series' Search"
    }
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        
        searchBar.placeholder = "Search Series"
        searchBar.showsCancelButton = true
        
        view.addSubview(searchBar)
        self.searchBar = searchBar
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        
        searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    func createTableView() {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "SeriesTableViewCell", bundle: nil), forCellReuseIdentifier: "SeriesTableViewCell")
        
        view.addSubview(tableView)
        self.tableView = tableView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.topAnchor.constraint(equalTo: searchBar!.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSeries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesTableViewCell", for: indexPath) as! SeriesTableViewCell
        
        let item = allSeries[indexPath.row]
        
        cell.seriesNameLabel!.text = item.show.name
        cell.seriesImageView?.sd_setImage(with: URL(string: item.show.image.medium))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowSeriesDetailSegue", sender: indexPath)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let text = searchBar.text {
            searchSeries(text) { [weak self] in
                self?.tableView?.reloadData()
            }
        } else {
            clearSeries { [weak self] in
                self?.tableView?.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        clearSeries { [weak self] in
            self?.tableView?.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else {
            return
        }
        
        selectedSeries = allSeries[indexPath.row]
    }

}
