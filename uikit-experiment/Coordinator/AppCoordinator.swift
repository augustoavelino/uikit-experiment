//
//  AppCoordinator.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 17/04/24.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {
    let navigationController: UINavigationController
    private(set) var children: [any Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.setViewControllers([homeViewController], animated: false)
    }
}
