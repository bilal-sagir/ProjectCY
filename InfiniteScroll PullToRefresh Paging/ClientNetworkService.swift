//
//  ClientNetworkService.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 6.05.2022.
//

import Foundation

protocol ClientNetworkServiceProtocol { // Bu yaklaşımı da sor
    func fetchUsers(completion: @escaping (RandomUsersDTO?, NetworkError?) -> Void)
}

class ClientNetworkService: ClientNetworkServiceProtocol {
    private enum Endpoints: Int {
        case userCount = 20
    }

    private let networkService: NetworkServiceProtocol = NetworkService()

    func fetchUsers(completion: @escaping (RandomUsersDTO?, NetworkError?) -> Void) {
        let urlString = Endpoints.userCount.rawValue
        networkService.get(from: urlString, completion: completion)
    }
}
