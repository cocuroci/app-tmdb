//
//  AppDelegate.swift
//  TMDB
//
//  Created by André Cocuroci on 20/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?
    var appContainer: AppContainer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appContainer = AppContainer()
        let appCoordinator = AppCoordinator(window: window, container: appContainer.container)
        
        self.window = window
        self.appCoordinator = appCoordinator
        self.appContainer = appContainer
        
        self.window?.makeKeyAndVisible()
        self.appCoordinator?.start()
        
        return true
    }
}

