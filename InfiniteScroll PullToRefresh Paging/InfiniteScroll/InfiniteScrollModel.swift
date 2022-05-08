//
//  InfiniteScrollModel.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 5.05.2022.
//

import Foundation

struct InfiniteScrollModel {
    let name: String
    let surname: String
    let profileImageString: String

    init(title: String, surname: String, profileImageString: String) {
        self.name = title
        self.surname = surname
        self.profileImageString = profileImageString
    }

    init(user: Result) { // convenience init farkı? struct olması?
        self.init(title: user.name.first, surname: user.name.last, profileImageString: user.picture.thumbnail)
    }
}
