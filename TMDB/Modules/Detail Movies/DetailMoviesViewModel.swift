//
//  DetailMoviesViewModel.swift
//  TMDB
//
//  Created by André Cocuroci on 21/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

class DetailMoviesViewModel: ViewModelType {
    
    private let dataProvider: MoviesDataProvider
    private (set) var detailMovies: [ItemMovie]
    private (set) var movie: Movie
    
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(movie: Movie, dataProvider: MoviesDataProvider) {
        self.movie = movie
        self.dataProvider = dataProvider
        self.detailMovies = []
        self.configurationDetail()
    }
    
    func getDetail() {
        self.dataProvider.detail(id: self.movie.id) { [weak self] updatedMovie, error in
            if let `error` = error {
                self?.onError?(error)
            } else if let `movie` = updatedMovie {
                self?.movie = `movie`
                self?.configurationDetail()
            }
        }
    }
    
    private func configurationDetail() {
        if self.detailMovies.count > 0 {
            self.detailMovies = []
        }
        
        self.detailMovies.append(ItemMovie(label: "Título:", description: self.movie.title))
        self.detailMovies.append(ItemMovie(label: "Sinópse:", description: self.movie.tagline))
        self.detailMovies.append(ItemMovie(label: "Descrição:", description: self.movie.overview))
        self.detailMovies.append(ItemMovie(label: "Lançamento:", description: self.movie.formattedReleaseDate))
        self.detailMovies.append(ItemMovie(label: "Gêneros:", description: self.reduceGenres()))
        
        self.detailMovies = self.detailMovies
            .filter { $0.description != nil }
            .filter { $0.description!.count > 0 }
        
        self.onSuccess?()
    }
    
    private func reduceGenres() -> String? {
        return self.movie.genres?.compactMap { $0.name }.reduce(nil, { (reducer, value) -> String in
            guard let `reducer` = reducer else {
                return value
            }
            
            return "\(reducer), \(value)"
        })
    }
}
