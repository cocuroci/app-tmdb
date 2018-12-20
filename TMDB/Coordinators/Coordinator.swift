//
//  Coordinator.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

protocol Event {}

protocol Coordinator: class {
    var parentCoordinator: Coordinator? { get set }
    func start()
    func handle(_ action: Event)
}

extension Coordinator {
    var parentCoordinator: Coordinator? {
        set { }
        get {
            return nil
        }
    }
}
