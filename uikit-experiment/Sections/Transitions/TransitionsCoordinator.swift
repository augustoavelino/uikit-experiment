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
    
    func performRoute(for transitionType: TransitionType) {
        switch transitionType {
        case .flip: presentFlipDestination()
        case .pageCurl: presentPageCurlDestination()
        }
    }
    
    private func presentFlipDestination() {
        let viewController = FlipDestinationViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func presentPageCurlDestination() {
        let viewController = PageCurlDestinationViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
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
        if toVC is FlipDestinationViewController || (fromVC is FlipDestinationViewController && isPopping) {
            return FlipTransitioning(reverse: isPopping)
        }
        if toVC is PageCurlDestinationViewController || (fromVC is PageCurlDestinationViewController && isPopping) {
            return PageCurlTransitioning(reverse: isPopping)
        }
        return nil
    }
}
