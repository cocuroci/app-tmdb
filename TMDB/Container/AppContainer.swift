//
//  AppContainer.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import Swinject
import Moya

class AppContainer {
    
    let container: Container
    
    init() {
        self.container = Container()
        self.registerServices()
        self.registerViews()
    }
    
    private func registerServices() {
        self.container.register(MoviesService.self) { _ in
            let provider: MoyaProvider<MoviesRouter> = MoyaProvider<MoviesRouter>(plugins: self.getPlugins())
            return MoviesServiceImpl(provider: provider)
        }
        
        self.container.register(ConfigurationService.self) { _ in
            let provider: MoyaProvider<ConfigurationRouter> = MoyaProvider<ConfigurationRouter>(plugins: self.getPlugins())
            return ConfigurationServiceImpl(provider: provider)
        }
        
        self.container.register(MoviesDataProvider.self) { resolver in
            let configuration = resolver.resolve(ConfigurationDataProvider.self)?.get()
            
            return NetworkMoviesDataProvider(
                service: resolver.resolve(MoviesService.self)!,
                configuration: configuration
            )
        }
        
        self.container.register(ConfigurationDataProvider.self) { resolver in
            return RequestConfigurationDataProvider(service: resolver.resolve(ConfigurationService.self)!)
        }
    }
    
    private func registerViews() {
        self.container.register(UpcomingMoviesView.self) { resolver in
            UpcomingMoviesView(
                dataProvider: resolver.resolve(MoviesDataProvider.self)!
            )
        }
        
        self.container.register(DetailMoviesView.self) {  resolver in
            DetailMoviesView(dataProvider: resolver.resolve(MoviesDataProvider.self)!)
        }
    }
    
    private func getPlugins() -> [PluginType] {
        var plugins = [PluginType]()
        
        plugins.append(NetworkLoggerPlugin(verbose: true))
        plugins.append(ApiTokenPlugin(apiToken: {
            Constants.apiToken
        }))
        
        return plugins
    }
}
