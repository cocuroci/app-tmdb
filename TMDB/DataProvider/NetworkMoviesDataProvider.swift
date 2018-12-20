//
//  NetworkMoviesDataProvider.swift
//  TMDB
//
//  Created by André Cocuroci on 21/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

class NetworkMoviesDataProvider: MoviesDataProvider {
 
    private let service: MoviesService
    private let configuration: Configuration?
    
    init(service: MoviesService, configuration: Configuration? = nil) {
        self.service = service
        self.configuration = configuration
    }
    
    func upcoming(onComplete: @escaping DataProviderComplete<[Movie]>) {
        self.service.upcoming { [weak self] result in
            switch result {
            case .success(let value):
                do {
                    let result = try value.map([Movie].self, atKeyPath: "results").map({ movie -> Movie in
                        var configuredMovie = movie
                        configuredMovie.config = self?.configuration
                        return configuredMovie
                    })
                    onComplete(result, nil)
                } catch {
                    onComplete([], error)
                }
            case .failure(let error):
                onComplete([], error)
            }
        }
    }
    
    func detail(id: Int, onComplete: @escaping DataProviderComplete<Movie?>) {
        self.service.detail(id: id) { result in
            switch result {
            case .success(let value):
                do {
                    let result = try value.map(Movie.self)
                    onComplete(result, nil)
                } catch {
                    onComplete(nil, error)
                }
            case .failure(let error):
                onComplete(nil, error)
            }
            
        }
    }
}
