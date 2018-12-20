//
//  MoviesServiceImpl.swift
//  TMDB
//
//  Created by André Cocuroci on 21/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Moya

class MoviesServiceImpl: MoviesService {

    let provider: MoyaProvider<MoviesRouter>
    
    init(provider: MoyaProvider<MoviesRouter>) {
        self.provider = provider
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
