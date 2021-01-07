//
//  AppDIContainer.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 30/12/20.
//

import UIKit

final class AppDIContainer {
    
    //TODO: Define Dependecies Here
    
    
    //MARK:- Scenes DI Container
    func createMovieSceneDIContainer() -> MovieScenesDIContainer {
        return MovieScenesDIContainer()
    }
}
