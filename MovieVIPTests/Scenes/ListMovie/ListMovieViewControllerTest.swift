//
//  ListMovieViewControllerTest.swift
//  MovieVIPTests
//
//  Created by Tifo Audi Alif Putra on 16/12/20.
//

@testable import MovieVIP
import XCTest

class ListMovieViewControllerTest: XCTestCase {
    
    // MARK:- Subject Under Test
    var interactor: MockListMovieInteractor!
    var sut: ListMovieViewController!
    var window: UIWindow!
    
    // MARK:- Test lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        window = UIWindow()
        prepareSystemUnderTest()
    }
    
    override func tearDownWithError() throws {
        window = nil
        try super.tearDownWithError()
    }
    
    func prepareSystemUnderTest() {
        interactor = MockListMovieInteractor()
        sut = ListMovieViewController(interactor: interactor)
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK:- Mock Objects
    class MockListMovieInteractor: ListMovieDataLogic {
        
        var movies: [Movie]?
        var fetchMoviesCalled = false
        
        func fetchMovies() {
            fetchMoviesCalled = true
        }
    }
    
    //MARK:- Testcases
    func testShouldFetchMoviesWhenViewDidAppear() {
        // Given
        loadView()
        
        // When
        sut.viewDidAppear(true)
        
        // Then
        XCTAssert(interactor.fetchMoviesCalled, "Should fetch movies when view did appear")
    }
    
    func testTableViewStateShouldPopulated() {
        // Given
        loadView()
        
        // When
        let movies = [Movie(id: 1, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", releaseDate: Date(), voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)]
        sut.displayMovies(movie: movies)
        
        // Then
        XCTAssert(sut.state == .populated, "state should be populated if have data")
    }
    
    func testTableViewStateShouldEmpty() {
        // Given
        loadView()
        
        // When
        sut.displayMovies(movie: [])
        
        // Then
        XCTAssert(sut.state == .empty, "state should be empty if have no data")
    }
    
    func testTableViewStateShouldError() {
        // Given
        loadView()
        
        // When
        let errorResponse = ErrorResponse.invalidResponse
        sut.displayErrorMessage(error: errorResponse)
        
        // Then
        XCTAssert(sut.state == .error, "state be should error")
    }
    
    func testNumberOfRowsShouldEqualWithTotalMovies() {
        // Given
        let tableView = sut.tableView
        loadView()
        
        // When
        let movies = [
            Movie(id: 1, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", releaseDate: Date(), voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil),
            Movie(id: 2, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", releaseDate: Date(), voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)
        ]
        
        sut.displayMovies(movie: movies)
        
        //Then
        let tableViewRow = tableView?.numberOfRows(inSection: 0)
        XCTAssertEqual(tableViewRow, movies.count, "total rows should be equal with total movies")
    }
}
