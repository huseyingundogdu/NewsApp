//
//  ExploreViewController.swift
//  NewsApp
//
//  Created by Huseyin on 20/12/2023.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
        
}

extension ExploreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //TODO: Add function that brings news about the searched word
        print(searchBar.text!)
    }
}
