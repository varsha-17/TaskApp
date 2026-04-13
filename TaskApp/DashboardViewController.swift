//
//  DashboardViewController.swift
//  TaskApp
//
//  Created by Varsha Sharma on 12/04/26.
//

import UIKit
import Alamofire

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    let primaryPink = UIColor(red: 0.95, green: 0.60, blue: 0.65, alpha: 0.25)
    let pastelYellow = UIColor(red: 1.0, green: 0.95, blue: 0.75, alpha: 1.0)
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLoader()
        fetchPosts()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func setupLoader() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func fetchPosts() {
        
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        AF.request(url).responseDecodable(of: [Post].self) { response in
            
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.posts = data
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showErrorAlert(message: "Failed to load data")
                }
            }
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let post = posts[indexPath.section]
        
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        
        if indexPath.section % 2 == 0 {
            cell.contentView.backgroundColor = pastelYellow
        } else {
            cell.contentView.backgroundColor = primaryPink
        }
        
        cell.contentView.layer.cornerRadius = 16
        cell.contentView.layer.masksToBounds = true
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
