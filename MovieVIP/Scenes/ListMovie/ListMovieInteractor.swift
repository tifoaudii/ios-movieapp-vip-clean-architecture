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
    
    var presenter: ListMoviePresentationLogic?
    var movieService: MovieService = MovieService(movieStore: MovieDataStore())
    var movies: [Movie]?
    
    func fetchMovies() {
        movieService.fetchMovies { [weak self] (movies: [Movie]) in
            guard let self = self else {
                return
            }
            
            self.movies = movies
            self.presenter?.displayMovies(movies: movies)
        } onFailure: { [weak self] (error: ErrorResponse) in
            guard let self = self else {
                return
            }
            
            self.presenter?.displayErrorMessage(error: error)
        }
    }
}
