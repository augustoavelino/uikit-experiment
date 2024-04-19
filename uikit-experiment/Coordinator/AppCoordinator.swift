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
    weak var parent: (any Coordinator)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func presentColorPicker() {
        let colorPickerViewController = ColorPickerViewController()
        colorPickerViewController.coordinator = self
        navigationController.pushViewController(colorPickerViewController, animated: true)
    }
    
    func presentTransitions() {
        let coordinator = TransitionsCoordinator(navigationController: navigationController)
        coordinator.parent = self
        children.append(coordinator)
        coordinator.start()
    }
    
    func removeChild(_ child: any Coordinator) {
        children.removeAll(where: { $0.isEqual(child) })
    }
}
