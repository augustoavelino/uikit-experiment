//
//  ColorPickerViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 17/04/24.
//

import UIKit

class ColorPickerViewController: UEViewController<AppCoordinator> {
    override func setupUI() {
        title = "Color Picker"
        view.backgroundColor = .systemBackground
    }
}
