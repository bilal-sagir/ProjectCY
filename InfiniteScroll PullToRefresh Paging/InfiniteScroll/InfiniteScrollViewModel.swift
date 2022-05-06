//
//  InfiniteScrollViewModel.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 5.05.2022.
//

import Foundation

protocol InfiniteScrollViewModelProtocol{
    var delegate: InfiniteScrollViewModelDelegate? { get set }
    var usersA: [InfiniteScrollModel]? { get set }
    func viewDidLoad()
}

protocol InfiniteScrollViewModelDelegate {
    func updateTableView () -> ()
}


class InfiniteScrollViewModel: InfiniteScrollViewModelProtocol {
    

    var delegate: InfiniteScrollViewModelDelegate?
    
    var service: ClientNetworkServiceProtocol!
    
    var usersA: [InfiniteScrollModel]? {
        didSet{
            delegate?.updateTableView()
        }
    }
    
    init(service: ClientNetworkServiceProtocol) {
        self.service = service
    }
    
    func fetchData(){
        service.fetchUsers { usr, err in
            let users = usr!.results.map(InfiniteScrollModel.init)
            self.usersA = users
            print(self.usersA![0].surname)
            print(self.usersA![0].name)
        }
    }
    
    func viewDidLoad() {
        fetchData()
    }
}
