//
//  MoviesService.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Moya
import Result

typealias ServiceComplete = (Result<Response, MoyaError>) -> Void

protocol MoviesService {
    func upcoming(onComplete: @escaping ServiceComplete)
    func detail(id: Int, onComplete: @escaping ServiceComplete)
}
