//
//  ConfigurationService.swift
//  TMDB
//
//  Created by André Cocuroci on 22/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Moya
import Result

typealias ConfigurationServiceComplete = (Result<Response, MoyaError>) -> Void

protocol ConfigurationService {
    func request(onComplete: @escaping ConfigurationServiceComplete)
}
