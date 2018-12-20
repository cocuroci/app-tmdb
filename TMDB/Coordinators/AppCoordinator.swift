//
//  AppCoordinator.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import UIKit
import Swinject

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let container: Container
    let configurationProvider: ConfigurationDataProvider
    
    var navigationController: UINavigationController?

    init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
        self.configurationProvider = container.resolve(ConfigurationDataProvider.self)!
    }
    
    func start() {
        if self.configurationProvider.get() == nil {
            self.showSplash()
        } else {
           self.showUpcomingMovies()
        }
    }
    
    func handle(_ action: Event) {
        switch action {
        case UpcomingMoviesViewAction.detail(let movie):
            self.showDetail(movie: movie)
        default: ()
        }
    }
    
    private func showSplash() {
        self.window.rootViewController = SplashView()
        self.requestConfiguration()
    }
    
    private func showUpcomingMovies() {
        let upcomingMovies = self.container.resolve(UpcomingMoviesView.self)!
        upcomingMovies.coordinator = self
        self.navigationController = UINavigationController(rootViewController: upcomingMovies)
        self.window.rootViewController = self.navigationController
    }
    
    private func requestConfiguration() {
        self.configurationProvider.request(onComplete: { [weak self] config, error in
            self?.showUpcomingMovies() //show upcoming movies even if request are any errors
        })
    }
    
    private func showDetail(movie: Movie) {
        let detailMovies = self.container.resolve(DetailMoviesView.self)!
        detailMovies.movie = movie
        self.navigationController?.pushViewController(detailMovies, animated: true)
    }
}
