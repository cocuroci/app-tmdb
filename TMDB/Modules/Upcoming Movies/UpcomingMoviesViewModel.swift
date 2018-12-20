//
//  UpcomingMoviesViewModel.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

class UpcomingMoviesViewModel: ViewModelType {
    
    private let dataProvider: MoviesDataProvider
    private (set) var result = [Movie]()
    
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(dataProvider: MoviesDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func getMovies() {
        self.dataProvider.upcoming { [weak self] result, error in
            if let `error` = error {
                self?.onError?(error)
            } else {
                self?.result = result
                self?.onSuccess?()
            }
        }
    }
}
