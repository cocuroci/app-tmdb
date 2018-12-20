//
//  GenreSpec.swift
//  TMDBTests
//
//  Created by André Cocuroci on 23/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import XCTest
@testable import TMDB

class GenreSpec: XCTestCase {
    
    var subject: Genre?
    var decoder: JSONDecoder!
    var dic: [String: Any]!
    var data: Data!
    
    override func setUp() {
        self.decoder = JSONDecoder()
    }
    
    func testCreateGenreWithJSON() {
        self.dic = MockEntitys.JSON.genreJSON
        self.data = try! JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        self.subject = try? self.decoder.decode(Genre.self, from: self.data)
        
        XCTAssertNotNil(self.subject)
        XCTAssertEqual(self.subject?.id, 1)
        XCTAssertEqual(self.subject?.name, "Comédia")
    }
    
    func testFailCreateGenreWithJSON() {
        self.dic = [:]
        self.data = try! JSONSerialization.data(withJSONObject: self.dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        self.subject = try? self.decoder.decode(Genre.self, from: self.data)
        
        XCTAssertNil(self.subject)
    }
}
