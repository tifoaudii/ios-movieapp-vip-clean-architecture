//
//  ListMovieInteractor.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 12/12/20.
//

import Foundation

protocol ListMovieDataLogic {
    func fetchMovies()
}

protocol ListMovieDataStore {
    var movies: [Movie]? { get }
}

class ListMovieInteractor: ListMovieDataLogic, ListMovieDataStore {
    
    private let presenter: ListMoviePresentationLogic
    private let movieService: MovieService
    
    var movies: [Movie]?
    
    init(presenter: ListMoviePresentationLogic, movieService: MovieService) {
        self.presenter = presenter
        self.movieService = movieService
    }
    
    func fetchMovies() {
        movieService.fetchMovies { [weak self] (movies: [Movie]) in
            guard let self = self else {
                return
            }
            
            self.movies = movies
            self.presenter.displayMovies(movies: movies)
        } onFailure: { [weak self] (error: ErrorResponse) in
            guard let self = self else {
                return
            }
            
            self.presenter.displayErrorMessage(error: error)
        }
    }
}
