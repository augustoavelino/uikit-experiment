//
//  FlipDestinationViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 18/04/24.
//

import UIKit

class FlipDestinationViewController: TransitionDestinationViewController {
    
    // MARK: - Actions
    
    @objc override func nextButtonAction(_ sender: UIButton) {
        coordinator?.performRoute(for: .flip)
    }
}
