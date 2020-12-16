//
//  MovieService.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 12/12/20.
//

import Foundation


protocol MovieStoreProtocol {
    func fetchMovies(success: @escaping (_ movie: MoviesResponse)-> Void, failure: @escaping (_ error: ErrorResponse)-> Void)
}

class MovieService {
    
    var movieStore: MovieStoreProtocol
    
    init(movieStore: MovieStoreProtocol) {
        self.movieStore = movieStore
    }
    
    func fetchMovies(onSuccess: @escaping (_ movies: [Movie]) -> Void, onFailure: @escaping (_ error: ErrorResponse) -> Void) {
        movieStore.fetchMovies { (response) in
            DispatchQueue.main.async {
                onSuccess(response.results)
            }
        } failure: { (error: ErrorResponse) in
            DispatchQueue.main.async {
                onFailure(error)
            }
        }
    }
}


public enum ErrorResponse: String {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var description: String {
        switch self {
        case .apiError: return "Ooops, there is something problem with the api"
        case .invalidEndpoint: return "Ooops, there is something problem with the endpoint"
        case .invalidResponse: return "Ooops, there is something problem with the response"
        case .noData: return "Ooops, there is something problem with the data"
        case .serializationError: return "Ooops, there is something problem with the serialization process"
        }
    }
}
