//
//  MovieScenesDIContainer.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 30/12/20.
//

import UIKit

final class MovieScenesDIContainer {
    
    //TODO: Define Dependecies Here
    
    
    //MARK:- Router
    
    func createMovieRouter(navigationController: UINavigationController) -> MovieRouter {
        return MovieRouter(navigationController: navigationController, dependencies: self)
    }
    
}

extension MovieScenesDIContainer: MovieRouterDependencies {
    
    //MARK:- Scenes
    
    func createListMovieViewController() -> ListMovieViewController {
        let presenter = ListMoviePresenter()
        
        let interactor = ListMovieInteractor(
            presenter: presenter,
            movieService: MovieService(
                movieStore: MovieDataStore()
            )
        )
        
        let viewController = ListMovieViewController(
            interactor: interactor
        )
        
        presenter.viewController = viewController
        return viewController
    }
}
