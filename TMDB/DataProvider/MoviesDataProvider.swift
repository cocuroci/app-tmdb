//
//  MoviesDataProvider.swift
//  TMDB
//
//  Created by André Cocuroci on 21/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Moya

typealias DataProviderComplete<T> = (_ result: T, _ error: Error?) -> Void

protocol MoviesDataProvider {
    func upcoming(onComplete: @escaping DataProviderComplete<[Movie]>)
    func detail(id: Int, onComplete: @escaping DataProviderComplete<Movie?>)
}
