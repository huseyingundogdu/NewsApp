//
//  ExploreViewController.swift
//  NewsApp
//
//  Created by Huseyin on 20/12/2023.
//

import UIKit
import Alamofire

class ExploreViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        registerTableViewCells()
        
    }
    
    func getNewsBySearchedWord(word: String) {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let formattedDate = dateFormatter.string(from: today)
        
        //TODO: pageSize is hardecoded
        let urlString = "https://newsapi.org/v2/everything?q=\(word)&from=\(formattedDate)&sortBy=popularity&pageSize=5&apiKey=\(K.APIKey)"
        
        AF.request(urlString).responseDecodable(of: News.self) { response in
            //TODO: Articles = response and show them on tableView.
            
            switch response.result {
            case .success(let news):
                self.articles = news.articles

            case .failure(let error):
                print("ExploreViewController response.result Error: \(error)")
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    func registerTableViewCells() {
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(newsCell, forCellReuseIdentifier: "NewsCell")
    }
    
}

extension ExploreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
            
            let article = articles[indexPath.row]
                
                cell.titleLabel.text = article.title
                cell.descriptionLabel.text = article.description
                
                //TODO: cell.newsImage.image
                cell.newsImage.image = UIImage(named: "placeholderImage")
            
            return cell
        
        
        //return UITableViewCell()
    }
    
}

extension ExploreViewController: UITableViewDelegate {
    
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //TODO: Add function that brings news about the searched word
        print(searchBar.text!)
        getNewsBySearchedWord(word: searchBar.text!)
    }
}
