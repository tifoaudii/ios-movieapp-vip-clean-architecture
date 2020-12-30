//
//  MovieRouter.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 30/12/20.
//

import UIKit

protocol MovieRouterDependencies {
    func createListMovieViewController() -> ListMovieViewController
}

final class MovieRouter {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MovieRouterDependencies
    
    init(navigationController: UINavigationController, dependencies: MovieRouterDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func startApp() {
        let listMovieViewController = dependencies.createListMovieViewController()
        navigationController?.pushViewController(listMovieViewController, animated: true)
    }
}
