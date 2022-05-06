//
//  HomeViewModel.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 5.05.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate? { get set }
    
    var listItems: [String] { get }
    func didSelectRow(indexpath: IndexPath)
    var viewTitle: String { get }
}

enum ViewRoute {
    case infiniteView
    case pullToRefresh
    case combined
}

protocol HomeViewModelDelegate: NSObject {

    func navigate(to route: ViewRoute)
}

class HomeViewModel: HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate?
    
    var listItems = ["Infinite Scroll", "Pull To Refresh", "Combined"]
    
    var viewTitle = "Home"
    
    func didSelectRow(indexpath: IndexPath) {

        if listItems[indexpath.row] == "Infinite Scroll" {
            self.delegate?.navigate(to: .infiniteView)
        }

        if listItems[indexpath.row] == "Pull To Refresh" {
            self.delegate?.navigate(to: .pullToRefresh)
        }

        if listItems[indexpath.row] == "Combined" {
            self.delegate?.navigate(to: .combined)
        }
    }
}
