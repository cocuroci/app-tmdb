//
//  Configuration.swift
//  TMDB
//
//  Created by André Cocuroci on 22/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

struct Configuration: Codable, Equatable {
    let baseUrl: String
    let secureBaseUrl: String
    let posterSizes: [String]
    let backdropSizes: [String]
    
    init(baseUrl: String, secureBaseUrl: String, posterSizes: [String] = [], backdropSizes: [String] = []) {
        self.baseUrl = baseUrl
        self.secureBaseUrl = secureBaseUrl
        self.posterSizes = posterSizes
        self.backdropSizes = backdropSizes
    }
    
    private enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case posterSizes = "poster_sizes"
        case backdropSizes = "backdrop_sizes"
    }
}
