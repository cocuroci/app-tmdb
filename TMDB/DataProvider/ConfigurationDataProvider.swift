//
//  ConfigurationDataProvider.swift
//  TMDB
//
//  Created by André Cocuroci on 22/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

typealias ConfigurationDataProviderComplete = (_ result: Configuration?, _ error: Error?) -> Void

protocol ConfigurationDataProvider {
    func get() -> Configuration?
    func save(_ configuration: Configuration) throws
    func request(onComplete: @escaping ConfigurationDataProviderComplete)
}
