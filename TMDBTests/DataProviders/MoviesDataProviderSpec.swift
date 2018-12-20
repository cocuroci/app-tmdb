//
//  MoviesDataProviderSpec.swift
//  TMDBTests
//
//  Created by André Cocuroci on 23/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import XCTest
@testable import TMDB

class MoviesDataProviderSpec: XCTestCase {
    
    var subject: MoviesDataProvider?
    
    func testUpcomingMoviesRequestSuccess() {
        self.subject = NetworkMoviesDataProvider(service: MockMoviesService(), configuration: MockEntitys.configuration)
        
        let expect = self.expectation(description: "Request movies success")
        var movies: [Movie]?
        var error: Error?
        
        subject?.upcoming(onComplete: { resultMovies, resultError in
            movies = resultMovies
            error = resultError
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertEqual(movies?.count, 1)
        XCTAssertNil(error)
    }
    
    func testUpcomingMoviesRequestFail() {
        self.subject = NetworkMoviesDataProvider(service: MockMoviesService(success: false, errorStatusCode: 401), configuration: MockEntitys.configuration)
        
        let expect = self.expectation(description: "Request movies fail")
        var movies: [Movie]?
        var error: Error?
        
        subject?.upcoming(onComplete: { resultMovies, resultError in
            movies = resultMovies
            error = resultError
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertEqual(movies?.count, 0)
        XCTAssertNotNil(error)
    }
    
    func testDetailMoviesRequestSuccess() {
        self.subject = NetworkMoviesDataProvider(service: MockMoviesService(), configuration: MockEntitys.configuration)
        
        let expect = self.expectation(description: "Request detail movie success")
        var movies: Movie?
        var error: Error?
        
        subject?.detail(id: 1, onComplete: { resultMovies, resultError in
            movies = resultMovies
            error = resultError
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertNotNil(movies)
        XCTAssertNil(error)
    }
    
    func testDetailMoviesRequestFail() {
        self.subject = NetworkMoviesDataProvider(service: MockMoviesService(success: false, errorStatusCode: 401), configuration: MockEntitys.configuration)
        
        let expect = self.expectation(description: "Request detail movie fail")
        var movies: Movie?
        var error: Error?
        
        subject?.detail(id: 1, onComplete: { resultMovies, resultError in
            movies = resultMovies
            error = resultError
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertNil(movies)
        XCTAssertNotNil(error)
    }
}
