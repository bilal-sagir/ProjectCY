//
//  AppRouter.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 6.05.2022.
//

import Foundation
import UIKit

class AppRouter {
    func start(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let homeView = HomeViewBuilder.build()
        let navigationController = UINavigationController(rootViewController: homeView)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.windowScene = scene
        return window
    }
}
