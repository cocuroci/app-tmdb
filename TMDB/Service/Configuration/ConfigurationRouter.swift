//
//  ConfigurationRouter.swift
//  TMDB
//
//  Created by André Cocuroci on 22/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Moya

enum ConfigurationRouter {
    case request
}

extension ConfigurationRouter: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseUrl)!
    }
    
    var path: String {
        return "configuration"
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return jsonSerializedUTF8(json: ["images": ["base_url": "http://baseUrl.com/",
                                          "secure_base_url": "https://baseUrl.com/",
                                          "poster_sizes": ["1", "2"],
                                          "backdrop_sizes": ["1", "2"]]])
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
