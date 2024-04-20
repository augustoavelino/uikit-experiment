//
//  PresentDestinationViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 20/04/24.
//

import UIKit

class PresentDestinationViewController: TransitionDestinationViewController {
    override init(transitionType: TransitionType) {
        super.init(transitionType: transitionType)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = modalStyle(forTransition: transitionType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        nextButton.removeFromSuperview()
        previousButton.setTitle("Dismiss", for: .normal)
    }
    
    override func previousButtonAction(_ sender: UIButton) {
        // TODO: Find a solution for animated dismiss when modalTransitionStyle is partialCurl
        dismiss(animated: modalTransitionStyle != .partialCurl)
    }
    
    private func modalStyle(forTransition transitionType: TransitionType) ->  UIModalTransitionStyle {
        switch transitionType {
        case .crossDissolve: .crossDissolve
        case .flip: .flipHorizontal
        case .pageCurl: .partialCurl
        }
    }
}
