//
//  Coordinator.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 17/04/24.
//

import UIKit

protocol Coordinator: NSObject {
    var navigationController: UINavigationController { get }
    var children: [any Coordinator] { get }
    var parent: (any Coordinator)? { get set }
    func start()
    func removeChild(_ child: any Coordinator)
}
