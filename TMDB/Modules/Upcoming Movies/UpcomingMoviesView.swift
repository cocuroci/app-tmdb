//
//  UpcomingMoviesView.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import UIKit

import Moya

enum UpcomingMoviesViewAction: Event {
    case detail(movie: Movie)
}

class UpcomingMoviesView: UIViewController {
    
    var viewModel: UpcomingMoviesViewModel!
    
    let dataProvider: MoviesDataProvider
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var coordinator: Coordinator?
    
    init(dataProvider: MoviesDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: String(describing: UpcomingMoviesView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupViews()
        self.setupBindings()
    }
}

extension UpcomingMoviesView {
    private func setupViewModel() {
        self.viewModel = UpcomingMoviesViewModel(
            dataProvider: self.dataProvider
        )
    }
    
    private func setupViews() {
        self.title = "Próximos filmes"
        self.collectionView.register(UINib(nibName: "ListMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListMoviesCollectionViewCell")
        self.collectionView.collectionViewLayout = UpcomingMoviesLayout()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupBindings() {
        self.viewModel.onSuccess = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        self.viewModel.onError = { [weak self] error in
            self?.showError(error: error)
        }
        
        self.viewModel.getMovies()
    }
}

extension UpcomingMoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.viewModel.result[indexPath.item]
        self.coordinator?.handle(UpcomingMoviesViewAction.detail(movie: movie))
    }
}

extension UpcomingMoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListMoviesCollectionViewCell", for: indexPath)
        
        if let `cell` = cell as? ListMoviesCollectionViewCell {
            cell.movie = self.viewModel.result[indexPath.item]
        }
        
        return cell
    }
}
