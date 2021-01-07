//
//  ListMovieInteractorTest.swift
//  MovieVIPTests
//
//  Created by Tifo Audi Alif Putra on 16/12/20.
//

@testable import MovieVIP
import XCTest


class ListMovieInteractorTest: XCTestCase {
    
    // MARK:- Helper Property
    enum TestScenario {
        case success
        case failed
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK:- Mock Object
    class MockListMoviePresenter: ListMoviePresentationLogic {
        
        var displayMoviesCalled = false
        var displayErrorMessageCalled = false
        
        func displayMovies(movies: [Movie]) {
            displayMoviesCalled = true
        }
        
        func displayErrorMessage(error: ErrorResponse) {
            displayErrorMessageCalled = true
        }
    }
    
    class MockMovieService: MovieService {
        
        var fetchMoviesCalled = false
        
        let testScenario: TestScenario
        
        init(testScenario: TestScenario) {
            self.testScenario = testScenario
            super.init(movieStore: MockMovieDataStore(testScenario: testScenario))
        }
        
        override func fetchMovies(onSuccess: @escaping ([Movie]) -> Void, onFailure: @escaping (ErrorResponse) -> Void) {
            fetchMoviesCalled = true
            self.movieStore.fetchMovies { (response: MoviesResponse) in
                onSuccess(response.results)
            } failure: { (error: ErrorResponse) in
                onFailure(error)
            }
        }
    }
    
    class MockMovieDataStore: MovieStoreProtocol {
        
        let testScenario: TestScenario
        
        init(testScenario: TestScenario) {
            self.testScenario = testScenario
        }
        
        let mockResponse = MoviesResponse(page: 1, totalResults: 1, totalPages: 1, results: [
            Movie(id: 1, title: "mock title", backdropPath: nil, posterPath: nil, overview: "mock overview", releaseDate: Date(), voteAverage: 10, voteCount: 10, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: 10)
        ])
        
        let errorResponse = ErrorResponse.invalidResponse
        
        func fetchMovies(success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
            if testScenario == .success {
                success(mockResponse)
            } else {
                failure(errorResponse)
            }
        }
    }
    
    // MARK:- TestCases
    func testFetchMoviesShouldAskMovieServiceToFetch() {
        
        //Given
        let presenter = MockListMoviePresenter()
        let service = MockMovieService(testScenario: .success)
        let interactor = ListMovieInteractor(presenter: presenter, movieService: service)
        
        //When
        interactor.fetchMovies()
        
        //Then
        XCTAssert(service.fetchMoviesCalled, "Movie Service should fetch the movie from endpoint")
    }
    
    func testFetchMovieShouldAskPresenterToDisplayTheMovies() {
        
        //Given
        let presenter = MockListMoviePresenter()
        let service = MockMovieService(testScenario: .success)
        let interactor = ListMovieInteractor(presenter: presenter, movieService: service)
        
        // When
        interactor.fetchMovies()
        
        // Then
        XCTAssert(presenter.displayMoviesCalled, "Presenter should display the movies after finish fetch it")
    }
    
    func testFetchMovieShouldAskPresenterToDisplayErrorMessageIfRequestNotSucceed() {
        
        //Given
        let presenter = MockListMoviePresenter()
        let service = MockMovieService(testScenario: .failed)
        let interactor = ListMovieInteractor(presenter: presenter, movieService: service)
        
        // When
        interactor.fetchMovies()
        
        //Then
        XCTAssert(presenter.displayErrorMessageCalled, "Presenter should display error message if failed fetch movies")
    }
}
