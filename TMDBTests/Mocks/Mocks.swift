//
//  Mocks.swift
//  TMDBTests
//
//  Created by André Cocuroci on 23/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation
import Moya
@testable import TMDB

struct MockEntitys {
    
    private init() {}
    
    struct JSON {
        private init() {}
        
        static let movieJSON: [String: Any] = ["id": 12345,
                                               "title": "Title",
                                               "poster_path": "/poster_path",
                                               "backdrop_path" : "/backdrop_path",
                                               "release_date": "2018-05-03",
                                               "overview": "overview"]
        
        static let movieCompleteJSON: [String: Any] = ["id": 12345,
                                               "title": "Title",
                                               "poster_path": "/poster_path",
                                               "backdrop_path" : "/backdrop_path",
                                               "release_date": "2018-05-03",
                                               "genres": [MockEntitys.JSON.genreJSON],
                                               "tagline": "tagline",
                                               "overview": "overview"]
        
        static let genreJSON: [String: Any] = ["id": 1, "name": "Comédia"]
        
        static let configurationJSON: [String: Any] = ["base_url": "http://baseUrl.com/",
                                                       "secure_base_url": "https://baseUrl.com/",
                                                       "poster_sizes": ["1", "2"],
                                                       "backdrop_sizes": ["1", "2"]]
    }
    
    static let movie = Movie(
        id: 1, title: "Title",
        posterPath: "poster_path",
        backdropPath: "backdropPath",
        releaseDate: "2018-05-03",
        overview: "overview",
        genres: nil,
        tagline: nil,
        config: MockEntitys.configuration
    )
    
    static let movieComplete = Movie(
        id: 1, title: "Title",
        posterPath: "poster_path",
        backdropPath: "backdropPath",
        releaseDate: "2018-05-03",
        overview: "overview",
        genres: [MockEntitys.genre],
        tagline: "tagline",
        config: MockEntitys.configuration
    )
    
    static let genre = Genre(
        id: 1,
        name: "Comédia"
    )
    
    static let configuration = Configuration(
        baseUrl: "http://baseUrl.com/",
        secureBaseUrl: "https://baseUrl.com/",
        posterSizes: ["1","2"],
        backdropSizes: ["1","2"]
    )
    
}

class MockMoviesService: MoviesService {
    
    let isSuccess: Bool
    let provider: MoyaProvider<MoviesRouter>
    
    init(success: Bool = true, errorStatusCode: Int? = nil) {
        self.isSuccess = success
        
        if self.isSuccess {
            self.provider = MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
        } else {
            let endpointClosure = { (target: MoviesRouter) -> Endpoint in
                let url = URL(target: target).absoluteString
                return Endpoint(url: url, sampleResponseClosure: {.networkResponse(errorStatusCode ?? 401, Data())}, method: target.method, task: target.task, httpHeaderFields: target.headers)
            }
            
            self.provider = MoyaProvider(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        }
    }
    
    func upcoming(onComplete: @escaping ServiceComplete) {
        self.provider.request(.upcomingMovies) { result in
            onComplete(result)
        }
    }
    
    func detail(id: Int, onComplete: @escaping ServiceComplete) {
        self.provider.request(.detail(id: id)) { result in
            onComplete(result)
        }
    }
}


class MockConfigurationService: ConfigurationService {
    
    let isSuccess: Bool
    let provider: MoyaProvider<ConfigurationRouter>
    
    init(success: Bool = true, errorStatusCode: Int? = nil) {
        self.isSuccess = success
        
        if self.isSuccess {
            self.provider = MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
        } else {
            let endpointClosure = { (target: ConfigurationRouter) -> Endpoint in
                let url = URL(target: target).absoluteString
                return Endpoint(url: url, sampleResponseClosure: {.networkResponse(errorStatusCode ?? 401, Data())}, method: target.method, task: target.task, httpHeaderFields: target.headers)
            }
            
            self.provider = MoyaProvider(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        }
    }
    
    func request(onComplete: @escaping ConfigurationServiceComplete) {
        self.provider.request(.request) { result in
            onComplete(result)
        }
    }

}
