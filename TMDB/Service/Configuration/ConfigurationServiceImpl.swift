//
//  ConfigurationServiceImpl.swift
//  TMDB
//
//  Created by André Cocuroci on 22/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Moya

class ConfigurationServiceImpl: ConfigurationService {
    
    let provider: MoyaProvider<ConfigurationRouter>
    
    init(provider: MoyaProvider<ConfigurationRouter>) {
        self.provider = provider
    }
    
    func request(onComplete: @escaping ConfigurationServiceComplete) {
        self.provider.request(.request) { result in
            onComplete(result)
        }
    }
}
