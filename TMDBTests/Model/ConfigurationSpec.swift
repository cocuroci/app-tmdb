//
//  ConfigurationSpec.swift
//  TMDBTests
//
//  Created by André Cocuroci on 23/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import XCTest
@testable import TMDB

class ConfigurationSpec: XCTestCase {
    
    var subject: Configuration?
    var decoder: JSONDecoder!
    var dic: [String: Any]!
    var data: Data!
    
    override func setUp() {
        self.decoder = JSONDecoder()
    }
    
    func testCreateConfigurationWithJSON() {
        self.dic = MockEntitys.JSON.configurationJSON
        self.data = try! JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        self.subject = try? self.decoder.decode(Configuration.self, from: self.data)
        
        XCTAssertNotNil(self.subject)
        XCTAssertEqual(self.subject?.baseUrl, "http://baseUrl.com/")
        XCTAssertEqual(self.subject?.secureBaseUrl, "https://baseUrl.com/")
        XCTAssertEqual(self.subject?.posterSizes, ["1", "2"])
        XCTAssertEqual(self.subject?.backdropSizes, ["1", "2"])
    }
    
    func testFailCreateGenreWithJSON() {
        self.dic = [:]
        self.data = try! JSONSerialization.data(withJSONObject: self.dic, options: JSONSerialization.WritingOptions.prettyPrinted)
        self.subject = try? self.decoder.decode(Configuration.self, from: self.data)
        
        XCTAssertNil(self.subject)
    }
}
