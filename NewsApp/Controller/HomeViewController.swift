//
//  ViewController.swift
//  NewsApp
//
//  Created by Huseyin on 16/12/2023.
//

import UIKit
import Alamofire


class HomeViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        registerTableViewCells()
        
        getNews()

    }
    
    func getNews() {
        AF.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=\(K.APIKey)").responseDecodable(of: News.self) { response in
            
            switch response.result {
            case .success(let news):
                self.articles = news.articles
            case .failure(let error):
                print("errorXXX: \(error)")
            }
            self.tableView.reloadData()
        }
    }
    
    func registerTableViewCells() {
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(newsCell, forCellReuseIdentifier: "NewsCell")
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
            
            if let article = articles?[indexPath.row] {
                
                cell.titleLabel.text = article.title
                cell.descriptionLabel.text = article.description
                
                //TODO: cell.newsImage.image
                cell.newsImage.image = UIImage(named: "placeholderImage")
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

