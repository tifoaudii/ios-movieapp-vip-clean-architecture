//
//  ListMoviePresenterTest.swift
//  MovieVIPTests
//
//  Created by Tifo Audi Alif Putra on 16/12/20.
//

@testable import MovieVIP
import XCTest

class ListMoviePresenterTest: XCTestCase {
    
    // MARK:- System Under Test
    var sut: ListMoviePresenter!

    // MARK:- Lifecyle
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ListMoviePresenter()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK:- Mock Objects
    class MockListMovieViewController: ListMovieDisplayLogic {
        
        var displayMoviesCalled = false
        var displayErrorMessageCalled = false
        
        func displayMovies(movie: [Movie]) {
            displayMoviesCalled = true
        }
        
        func displayErrorMessage(error: ErrorResponse) {
            displayErrorMessageCalled = true
        }
    }
    
    // MARK:- Testcases
    
    func testPresenterShouldAskViewControllerToDisplayMovies() {
        // Given
        let mockListMovieViewController = MockListMovieViewController()
        sut.viewController = mockListMovieViewController
        
        let mockMovies = [
            Movie(id: 1, title: "mock title 1", backdropPath: nil, posterPath: nil, overview: "mock overview", releaseDate: Date(), voteAverage: 10, voteCount: 10, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: 10),
            Movie(id: 2, title: "mock title 2", backdropPath: nil, posterPath: nil, overview: "mock overview", releaseDate: Date(), voteAverage: 10, voteCount: 10, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: 10),
            Movie(id: 3, title: "mock title 3", backdropPath: nil, posterPath: nil, overview: "mock overview", releaseDate: Date(), voteAverage: 10, voteCount: 10, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: 10)
        ]
        
        // When
        sut.displayMovies(movies: mockMovies)
        
        // Then
        XCTAssert(mockListMovieViewController.displayMoviesCalled, "View Controller should called display movies")
    }
    
    func testPresenterShouldAskViewControllerToDisplayErrorMessage() {
        // Given
        let mockListMovieViewController = MockListMovieViewController()
        sut.viewController = mockListMovieViewController
        
        let errorResponse = ErrorResponse.invalidResponse
        
        // When
        sut.displayErrorMessage(error: errorResponse)
        
        // Then
        XCTAssert(mockListMovieViewController.displayErrorMessageCalled, "View Controller should called display error message")
    }
}
