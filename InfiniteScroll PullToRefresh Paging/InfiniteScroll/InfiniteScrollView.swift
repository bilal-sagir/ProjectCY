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
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = InfiniteScrollViewModel(service: appContainer.service) // TODO: burayı inject ediceksin unutma
        
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        self.title = "Infinite ScrollView"
        
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
}

//MARK: - viewModel Delegation
extension InfiniteScrollView: InfiniteScrollViewModelDelegate {
    func updateTableView() {
        self.tableView.reloadData()
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
        //cell.accessibilityNavigationStyle = .combined
        cell.textLabel?.text = viewModel.usersA?[indexPath.row].surname
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("go profile")
    }
}
