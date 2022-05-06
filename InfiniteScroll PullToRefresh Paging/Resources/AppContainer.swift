//
//  AppContainer.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 6.05.2022.
//

import Foundation

let appContainer = AppContainer() // Bu kullanım nasıl? Dışarda olması ve instanceları aynı yerde olusturmak?

class AppContainer {
    let router = AppRouter()
    let service: ClientNetworkService = ClientNetworkService()
}
