//
//  RequestConfigurationDataProvider.swift
//  TMDB
//
//  Created by André Cocuroci on 22/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

class RequestConfigurationDataProvider: ConfigurationDataProvider {
    
    private struct Keys {
        private init() {}
        static let configurationKey = "configurationKey"
    }
    
    let service: ConfigurationService
    let userDefaults: UserDefaults
    let jsonEncoder: JSONEncoder
    let jsonDecoder: JSONDecoder
    
    init(service: ConfigurationService,
         userDefaults: UserDefaults = UserDefaults.standard,
         jsonEncoder: JSONEncoder = JSONEncoder(),
         jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.service = service
        self.userDefaults = userDefaults
        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder
    }
    
    func get() -> Configuration? {
        guard let data = userDefaults.data(forKey: Keys.configurationKey),
            let config = try? jsonDecoder.decode(Configuration.self, from: data) else {
                return nil
        }
        
        return config
    }
    
    func save(_ configuration: Configuration) throws {
        do {
            let data = try jsonEncoder.encode(configuration)
            userDefaults.set(data, forKey: Keys.configurationKey)
        } catch {
            throw error
        }
    }
    
    func request(onComplete: @escaping (Configuration?, Error?) -> Void) {
        self.service.request { [weak self] result in
            switch result {
            case .success(let value):
                do {
                    let config = try value.map(Configuration.self, atKeyPath: "images")
                    try self?.save(config)
                    onComplete(config, nil)
                } catch {
                    onComplete(nil, error)
                }
            case .failure(let error):
                onComplete(nil,error)
            }
        }
    }
    
}
