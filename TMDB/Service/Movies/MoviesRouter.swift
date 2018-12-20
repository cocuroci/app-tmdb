//
//  MoviesRouter.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Moya

enum MoviesRouter {
    case upcomingMovies
    case detail(id: Int)
}

extension MoviesRouter: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .upcomingMovies:
            return "movie/upcoming"
        case .detail(let id):
            return "movie/\(id)"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .upcomingMovies:
            return jsonSerializedUTF8(json: ["results": [["id": 12345,
                                                    "title": "Title",
                                                    "poster_path": "/poster_path",
                                                    "backdrop_path" : "/backdrop_path",
                                                    "release_date": "2018-05-03",
                                                    "genres": [["id": 1, "name": "Comédia"]],
                                                    "tagline": "tagline",
                                                    "overview": "overview"]]])
        case .detail:
            return jsonSerializedUTF8(json: ["id": 12345,
                                                         "title": "Title",
                                                         "poster_path": "/poster_path",
                                                         "backdrop_path" : "/backdrop_path",
                                                         "release_date": "2018-05-03",
                                                         "genres": [["id": 1, "name": "Comédia"]],
                                                         "tagline": "tagline",
                                                         "overview": "overview"])
        }
    }
    
    var task: Task {
        return Task.requestParameters(parameters: ["language": "pt-BR"], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
