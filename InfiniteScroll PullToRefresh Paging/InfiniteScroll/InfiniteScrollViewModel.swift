//
//  InfiniteScrollViewModel.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 5.05.2022.
//

import Foundation

protocol InfiniteScrollViewModelProtocol{
    var delegate: InfiniteScrollViewModelDelegate? { get set }
    var pagingRequest: Bool { get set }
    var usersA: [InfiniteScrollModel]? { get set }
    func fetchData(firstPaging: Bool)
}

protocol InfiniteScrollViewModelDelegate {
    func updateTableView () -> ()
}


class InfiniteScrollViewModel: InfiniteScrollViewModelProtocol {
    
    var pagingRequest = true
    
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
    
    func fetchData(firstPaging: Bool){
        
        pagingRequest = true
        
        if firstPaging{
            //if pagingRequest { return }
            service.fetchUsers { usr, err in
                guard let usr = usr else { return }
                let users = usr.results.map(InfiniteScrollModel.init)
                self.usersA = users
                
                //self.pagingRequest = false
                print(self.usersA?.count)
                print("first")
            }
        } else {
            if !pagingRequest { return }
            service.fetchUsers { usr, err in
                guard let usr = usr else { return }
                let users = usr.results.map(InfiniteScrollModel.init)
                self.usersA?.append(contentsOf: users)
                
                //self.pagingRequest = false
                print(self.usersA?.count)
            }
        }
        //self.pagingRequest = true
    }
}
