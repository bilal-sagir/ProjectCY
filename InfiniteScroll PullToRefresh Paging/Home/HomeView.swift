//
//  HomeView.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 5.05.2022.
//
import Foundation
import UIKit

class HomeView: UIViewController {

//MARK: - Variables
    var viewModel: HomeViewModelProtocol!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        
        return table
    }()
    
//MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
//MARK: - Helpers
    func configureUI() {
        viewModel = HomeViewModel()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        view.addSubview(tableView)
        self.title = viewModel.viewTitle
    }
}

//MARK: - viewModelDelegation
extension HomeView: HomeViewModelDelegate { //Dogru yaklaşım mı emin değilim. Scalable gibi?
    
    func navigate(to route: ViewRoute) {
        switch route {
        case .infiniteView:
            navigationController?.pushViewController(InfiniteScrollView(), animated: true)
        case .pullToRefresh:
            navigationController?.pushViewController(PullToRefreshView(), animated: true)
        case .combined:
            break
        }
    }
}

//MARK: - tableview delegation datasource
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.listItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexpath: indexPath)
    }
}
