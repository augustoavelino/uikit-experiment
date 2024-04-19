//
//  PageCurlDestinationViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 19/04/24.
//

import UIKit

class PageCurlDestinationViewController: TransitionDestinationViewController {
    
    // MARK: - Actions
    
    @objc override func nextButtonAction(_ sender: UIButton) {
        coordinator?.performRoute(for: .pageCurl)
    }
}
