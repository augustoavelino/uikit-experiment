//
//  UEViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 17/04/24.
//

import UIKit

class UEViewController<CoordinatorType: Coordinator>: UIViewController {
    weak var coordinator: CoordinatorType?
    
    override func viewDidLoad() {
        setupUI()
        bindUI()
    }
    
    func setupUI() {}
    func bindUI() {}
}
