//
//  PullToRefreshView.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 5.05.2022.
//

import Foundation
import UIKit

class PullToRefreshView: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.title = "PullToRefresh"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // For demo purposes
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

extension PullToRefreshView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "10"
        return cell
    }
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
}
