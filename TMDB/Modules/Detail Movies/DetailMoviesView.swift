//
//  DetailMoviesView.swift
//  TMDB
//
//  Created by André Cocuroci on 21/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import UIKit

class DetailMoviesView: UIViewController {
    
    var viewModel: DetailMoviesViewModel!
    var movie: Movie!
    
    let dataProvider: MoviesDataProvider
    
    @IBOutlet weak var tableView: UITableView!
    
    init(dataProvider: MoviesDataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: String(describing: DetailMoviesView.self), bundle: nil)
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

extension DetailMoviesView {
    private func setupViewModel() {
        self.viewModel = DetailMoviesViewModel(
            movie: self.movie,
            dataProvider: self.dataProvider
        )
    }
    
    private func setupViews() {
        self.title = self.viewModel.movie.title
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        headerView.contentMode = .scaleAspectFill
        headerView.kf.setImage(with: URL(string: self.viewModel.movie.formattedBackdropPath))
        self.tableView.tableHeaderView = headerView
    }
    
    private func setupBindings() {
        self.viewModel.onSuccess = { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.viewModel.onError = { [weak self] error in
            self?.showError(error: error)
        }
        
        self.viewModel.getDetail()
    }
}

extension DetailMoviesView: UITableViewDelegate {
    
}

extension DetailMoviesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.detailMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            return self.configureCell(cell, indexPath: indexPath)
        } else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.detailTextLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            return configureCell(cell, indexPath: indexPath)
        }
    }
    
    private func configureCell(_ cell: UITableViewCell, indexPath: IndexPath) -> UITableViewCell {
        let item = self.viewModel.detailMovies[indexPath.row]
        cell.textLabel?.text = item.label
        cell.detailTextLabel?.text = item.description
        return cell
    }
}
