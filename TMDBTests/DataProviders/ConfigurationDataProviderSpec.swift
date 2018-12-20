//
//  ConfigurationDataProviderSpec.swift
//  TMDBTests
//
//  Created by André Cocuroci on 23/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import XCTest
@testable import TMDB

class ConfigurationDataProviderSpec: XCTestCase {
    
    var subject: ConfigurationDataProvider?
    var userDefaults: UserDefaults = UserDefaults(suiteName: "testUserDefaults")!
    
    override func setUp() {
        self.userDefaults.removeObject(forKey: "configurationKey")
    }
    
    func testConfigurationRequestSuccess() {
        self.subject = RequestConfigurationDataProvider(service: MockConfigurationService(), userDefaults: userDefaults)
        
        let expect = self.expectation(description: "Request configuration success")
        var configuration: Configuration?
        var error: Error?
        
        self.subject?.request(onComplete: { resultConfiguration, resultError in
            configuration = resultConfiguration
            error = resultError
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertNotNil(configuration)
        XCTAssertNil(error)
    }
    
    func testConfigurationSaveSuccess() {
        self.subject = RequestConfigurationDataProvider(service: MockConfigurationService(), userDefaults: userDefaults)
        
        XCTAssertNil(self.subject?.get())
        
        let expect = self.expectation(description: "Request configuration success")
        var configuration: Configuration?
        var savedCondiguration: Configuration?
        var error: Error?
        
        self.subject?.request(onComplete: { resultConfiguration, resultError in
            configuration = resultConfiguration
            error = resultError
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        savedCondiguration = self.subject?.get()
        
        XCTAssertNotNil(savedCondiguration)
        XCTAssertNotNil(configuration)
        XCTAssertEqual(configuration, savedCondiguration)
        XCTAssertNil(error)
    }
    
    func testConfigurationRequestFail() {
        self.subject = RequestConfigurationDataProvider(service: MockConfigurationService(success: false, errorStatusCode: 401), userDefaults: userDefaults)
        
        let expect = self.expectation(description: "Request configuration fail")
        var configuration: Configuration?
        var error: Error?
        
        self.subject?.request(onComplete: { resultConfiguration, resultError in
            configuration = resultConfiguration
            error = resultError
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertNil(configuration)
        XCTAssertNotNil(error)
    }
}
