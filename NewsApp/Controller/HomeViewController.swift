//
//  ViewController.swift
//  NewsApp
//
//  Created by Huseyin on 16/12/2023.
//

import UIKit
import Alamofire
import SafariServices
import RealmSwift

class HomeViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        registerTableViewCells()
        
        setCountryButton()
        getNews(byCountry: K.defaultCountry)

    }

    func setCountryButton() {
        let countryArr = ["us", "pl", "tr"]
        
        var optionsArray: [UIAction] = []
        
        let optionClosure = {(action: UIAction) in
            self.getNews(byCountry: action.title)
        }
        
        for country in countryArr {
            let action = UIAction(title: country, state: .off, handler: optionClosure)
            optionsArray.append(action)
        }
        
        optionsArray[0].state = .on
        
        let optionsMenu = UIMenu(title: "Country", options: .displayInline, children: optionsArray)
        
        countryButton.menu = optionsMenu
        countryButton.changesSelectionAsPrimaryAction = true
        countryButton.showsMenuAsPrimaryAction = true
        
    }
    
    func getNews(byCountry: String) {
        AF.request("https://newsapi.org/v2/top-headlines?country=\(byCountry)&pageSize=25&apiKey=\(K.APIKey)").responseDecodable(of: News.self) { response in
            
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: K.Segues.toTheSingleNews, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: articles[indexPath.row].url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)

    }
    

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        let article = articles[indexPath.row]
        
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        
        //TODO: cell.newsImage.image
        //cell.newsImage.image = UIImage(named: "placeholderImage")
        
        if let imageUrl = article.urlToImage {
            
            AF.request(imageUrl).response { response in
                switch response.result {
                case .success(let imageData):
                    if let data = imageData {
                        cell.newsImage.image = UIImage(data: data)
                    }
                case .failure(let error):
                    print("Request failed: \(error)")
                    cell.newsImage.image = UIImage(named: "placeholderImage")
                }
            }
            
        }
        
        cell.shareButtonFnc = {[unowned self] in
            let activityController = UIActivityViewController(activityItems: [article.url], applicationActivities: nil)
            present(activityController, animated: true)
        }
        
        cell.saveButtonFnc = {[unowned self] in
            cell.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        
        return cell
    }
}

