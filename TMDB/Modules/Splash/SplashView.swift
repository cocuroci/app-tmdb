//
//  SplashView.swift
//  TMDB
//
//  Created by André Cocuroci on 22/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import UIKit

class SplashView: UIViewController {
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
}

extension SplashView {
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.activityIndicatorView)
        
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}
