//
//  ListMoviesCollectionViewCell.swift
//  TMDB
//
//  Created by André Cocuroci on 21/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import UIKit
import Kingfisher

class ListMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var movie: Movie! {
        didSet {
            self.updateLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateLayout() {
        self.titleLabel.text = movie.title
        self.dateLabel.text = movie.formattedReleaseDate
        self.imageView.kf.setImage(with: URL(string: self.movie.formattedPosterPath))
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
}
