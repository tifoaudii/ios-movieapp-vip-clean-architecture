//
//  ListMoviePresenter.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 12/12/20.
//

import Foundation

protocol ListMoviePresentationLogic {
    func displayMovies(movies: [Movie])
    func displayErrorMessage(error: ErrorResponse)
}

class ListMoviePresenter: ListMoviePresentationLogic {
    
    weak var viewController: ListMovieDisplayLogic?
    
    func displayMovies(movies: [Movie]) {
        viewController?.displayMovies(movie: movies)
    }
    
    func displayErrorMessage(error: ErrorResponse) {
        viewController?.displayErrorMessage(error: error)
    }
}
