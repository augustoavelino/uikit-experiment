//
//  ColorPickerViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 17/04/24.
//

import UIKit

class ColorPickerViewController: UEViewController<AppCoordinator> {
    
    // MARK: UI
    
    let currentColorView = ColorPickerPreviewCircle()
    let gradientView: ColorPickerGradientView = {
        let gradientView = ColorPickerGradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()
    
    // MARK: - Setup
    
    override func setupUI() {
        title = "Color Picker"
        view.backgroundColor = .systemBackground
        setupCurrentColorView()
        setupGradientView()
    }
    
    private func setupCurrentColorView() {
        view.addSubview(currentColorView)
        currentColorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0).isActive = true
        currentColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentColorView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
    }
    
    private func setupGradientView() {
        view.addSubview(gradientView)
        gradientView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        gradientView.heightAnchor.constraint(equalToConstant: 280.0).isActive = true
    }
}
