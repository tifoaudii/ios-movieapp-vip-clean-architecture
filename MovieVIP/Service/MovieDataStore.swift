//
//  MovieDataStore.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 12/12/20.
//

import Foundation

class MovieDataStore: MovieStoreProtocol {
    
    private let apiKey = "ae5b867ee790efe19598ff6108ad4e02"
    private let baseUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func fetchMovies(success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        guard var urlComponents = URLComponents(string: "\(baseUrl)/movie/top_rated") else {
            return failure(.invalidEndpoint)
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return failure(.invalidEndpoint)
        }
        
        urlSession.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if error != nil {
                return failure(.apiError)
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return failure(.invalidResponse)
            }
            
            guard let data = data else {
                return failure(.noData)
            }
            
            do {
                let movieResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    success(movieResponse)
                }
            } catch {
                return failure(.serializationError)
            }
        }.resume()
    }
}
