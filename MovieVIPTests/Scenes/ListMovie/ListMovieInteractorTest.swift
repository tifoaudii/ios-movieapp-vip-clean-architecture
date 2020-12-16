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
    
    // MARK:- Subject Under Test
    var sut: ListMovieInteractor!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ListMovieInteractor()
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
            if testScenario == .success {
                onSuccess([])
            } else {
                let mockErrorResponse = ErrorResponse.invalidResponse
                onFailure(mockErrorResponse)
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
        let mockMovieService = MockMovieService(testScenario: .success)
        sut.movieService = mockMovieService
        
        //When
        sut.fetchMovies()
        
        //Then
        XCTAssert(mockMovieService.fetchMoviesCalled, "Movie Service should fetch the movie from endpoint")
    }
    
    func testFetchMovieShouldAskPresenterToDisplayTheMovies() {
        
        //Given
        let mockMovieService = MockMovieService(testScenario: .success)
        
        let mockListMoviePresenter = MockListMoviePresenter()
        
        sut.presenter = mockListMoviePresenter
        sut.movieService = mockMovieService
        
        // When
        sut.fetchMovies()
        
        // Then
        XCTAssert(mockListMoviePresenter.displayMoviesCalled, "Presenter should display the movies after finish fetch it")
    }
    
    func testFetchMovieShouldAskPresenterToDisplayErrorMessageIfRequestNotSucceed() {
        
        // Given
        let mockMovieService = MockMovieService(testScenario: .failed)
        let mockListMoviePresenter = MockListMoviePresenter()
        
        sut.presenter = mockListMoviePresenter
        sut.movieService = mockMovieService
        
        // When
        sut.fetchMovies()
        
        //Then
        XCTAssert(mockListMoviePresenter.displayErrorMessageCalled, "Presenter should display error message if failed fetch movies")
    }
}
