//
//  InfiniteScrollView.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 5.05.2022.
//

import Foundation
import UIKit

class InfiniteScrollView: UIViewController {

    //MARK: - Variables
    
    var viewModel: InfiniteScrollViewModelProtocol!
    
    let refreshControl = UIRefreshControl()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = InfiniteScrollViewModel(service: appContainer.service)
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.fetchData(firstPaging: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // For demo purposes
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func configureUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        self.title = "Infinite ScrollView"
        
        viewModel.delegate = self
        viewModel.fetchData(firstPaging: true)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
}

//MARK: - viewModel Delegation
extension InfiniteScrollView: InfiniteScrollViewModelDelegate {
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - tableview delegation datasource
extension InfiniteScrollView: UITableViewDelegate, UITableViewDataSource {
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersA?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.usersA?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("go profile")
    }
}

//MARK: - ScrollView Delegations

extension InfiniteScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollFrame = scrollView.frame.size.height
        
        let table = self.tableView.contentSize.height
        let scroll = scrollView.contentOffset.y
        
        if scroll > table - scrollFrame {
            if viewModel.pagingRequest{
                
                viewModel.fetchData(firstPaging: false)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            viewModel.pagingRequest = false
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let scrollFrame = scrollView.frame.size.height
        
        let table = self.tableView.contentSize.height
        let scroll = scrollView.contentOffset.y
        
        if scroll < table - scrollFrame + 100 {
            viewModel.pagingRequest = true
        }
    }
}
