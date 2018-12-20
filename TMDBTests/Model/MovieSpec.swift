//
//  MovieSpec.swift
//  TMDBTests
//
//  Created by André Cocuroci on 23/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import XCTest
@testable import TMDB

class MovieSpec: XCTestCase {
    
    var subject: Movie?
    var decoder: JSONDecoder!
    var dic: [String: Any]!
    var data: Data!
    var configuration: Configuration?
    
    override func setUp() {
        self.decoder = JSONDecoder()
        self.configuration = MockEntitys.configuration
    }
    
    func testCreateSimpleMovieWithJSON() {
        self.dic = MockEntitys.JSON.movieJSON
        self.data = try! JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        self.subject = try? self.decoder.decode(Movie.self, from: self.data)
        
        XCTAssertNotNil(self.subject)
        XCTAssertEqual(self.subject?.title, "Title")
        XCTAssertEqual(self.subject?.posterPath, "/poster_path")
        XCTAssertEqual(self.subject?.backdropPath, "/backdrop_path")
        XCTAssertEqual(self.subject?.releaseDate, "2018-05-03")
        XCTAssertEqual(self.subject?.formattedReleaseDate, "03/05/2018")
        XCTAssertEqual(self.subject?.overview, "overview")
        XCTAssertNil(self.subject?.genres)
        XCTAssertNil(self.subject?.tagline)
    }
    
    func testCreateCompleteMovieWithJSON() {
        self.dic = MockEntitys.JSON.movieCompleteJSON
        self.data = try! JSONSerialization.data(withJSONObject: self.dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        self.subject = try? self.decoder.decode(Movie.self, from: self.data)
        self.subject?.config = self.configuration
        
        XCTAssertNotNil(self.subject)
        XCTAssertEqual(self.subject?.title, "Title")
        XCTAssertEqual(self.subject?.posterPath, "/poster_path")
        XCTAssertEqual(self.subject?.backdropPath, "/backdrop_path")
        XCTAssertEqual(self.subject?.releaseDate, "2018-05-03")
        XCTAssertEqual(self.subject?.formattedReleaseDate, "03/05/2018")
        XCTAssertEqual(self.subject?.formattedPosterPath, "https://baseUrl.com/2/poster_path")
        XCTAssertEqual(self.subject?.formattedBackdropPath, "https://baseUrl.com/1/backdrop_path")
        XCTAssertEqual(self.subject?.overview, "overview")
        XCTAssertNotNil(self.subject?.genres)
        XCTAssertNotNil(self.subject?.tagline)
    }
    
    func testFailCreateMovieWithJSON() {
        self.dic = [:]
        self.data = try! JSONSerialization.data(withJSONObject: self.dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        self.subject = try? self.decoder.decode(Movie.self, from: self.data)
        
        XCTAssertNil(self.subject)
    }
}
