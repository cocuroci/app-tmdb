//
//  ApiTokenPlugin.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Moya

class ApiTokenPlugin: PluginType {
    
    let apiToken: () -> String
    
    init(apiToken: @escaping () -> String) {
        self.apiToken = apiToken
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let url = request.url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return request
        }
        
        var request = request
        
        var queryItems = urlComponents.queryItems ?? []
        let queryItem = URLQueryItem(name: "api_key", value: self.apiToken())
        
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        
        request.url = urlComponents.url
        
        return request
    }
}
