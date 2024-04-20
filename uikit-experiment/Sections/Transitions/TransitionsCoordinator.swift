//
//  TransitionsCoordinator.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 18/04/24.
//

import UIKit

class TransitionsCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    private(set) var children: [any Coordinator] = []
    weak var parent: (any Coordinator)?
    weak var previousNavigationControllerDelegate: UINavigationControllerDelegate?
    private var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        previousNavigationControllerDelegate = navigationController.delegate
        self.navigationController.delegate = self
    }
    
    deinit {
        navigationController.delegate = previousNavigationControllerDelegate
    }
    
    private func removeFromParent() {
        parent?.removeChild(self)
    }
    
    func removeChild(_ child: any Coordinator) {
        children.removeAll(where: { $0.isEqual(child) })
    }
    
    func start() {
        let viewController = TransitionsViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
        rootViewController = viewController
    }
    
    func performRoute(for transitionType: TransitionType, push: Bool = true) {
        if push {
            let viewController = TransitionDestinationViewController(transitionType: transitionType)
            viewController.coordinator = self
            navigationController.pushViewController(viewController, animated: true)
        } else {
            let viewController = PresentDestinationViewController(transitionType: transitionType)
            viewController.coordinator = self
            navigationController.present(viewController, animated: true)
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension TransitionsCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        let isPopping = operation == .pop
        if fromVC.isEqual(rootViewController) && isPopping {
            removeFromParent()
            return nil
        }
        if let transitionDestination = toVC as? TransitionDestinationViewController {
            return transitioning(for: transitionDestination.transitionType, reverse: isPopping)
        } else if isPopping, let transitionOrigin = fromVC as? TransitionDestinationViewController {
            return transitioning(for: transitionOrigin.transitionType, reverse: true)
        }
        return nil
    }
    
    private func transitioning(for transitionType: TransitionType, reverse: Bool) -> (any UIViewControllerAnimatedTransitioning)? {
        switch transitionType {
        case .crossDissolve: CrossDissolveTransitioning(reverse: reverse)
        case .flip: FlipTransitioning(reverse: reverse)
        case .pageCurl: PageCurlTransitioning(reverse: reverse)
        }
    }
}
