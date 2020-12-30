//
//  AppRouter.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 30/12/20.
//

import UIKit

final class AppRouter {
    
    private let appDIContainer: AppDIContainer
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func startRoute() {
        let movieScenesDIContainer = appDIContainer.createMovieSceneDIContainer()
        let router = movieScenesDIContainer.createMovieRouter(navigationController: navigationController)
        router.startApp()
    }
}
