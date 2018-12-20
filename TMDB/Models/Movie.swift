//
//  Movie.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let overview: String
    
    var genres: [Genre]?
    var tagline: String?
    
    var config: Configuration?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case overview
        case genres
        case tagline
    }
    
    var formattedReleaseDate: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: self.releaseDate) else {
            return ""
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    var formattedPosterPath: String {
        guard let config = self.config,
            let size = config.posterSizes.dropFirst().first,
            let posterPath = self.posterPath  else {
            return  ""
        }
        
        return "\(config.secureBaseUrl)\(size)\(posterPath)"
    }
    
    var formattedBackdropPath: String {
        guard let config = self.config,
            let size = config.backdropSizes.first,
            let backdropPath = self.backdropPath  else {
            return  ""
        }
        
        return "\(config.secureBaseUrl)\(size)\(backdropPath)"
    }
}
