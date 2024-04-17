//
//  HomeViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 17/04/24.
//

import UIKit

class HomeViewController: UEViewController {
    
    // MARK: UI
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello World!"
        return label
    }()
    
    // MARK: - Setup
    
    override func setupUI() {
        setupLabel()
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
