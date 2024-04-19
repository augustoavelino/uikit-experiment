//
//  ColorPickerViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 17/04/24.
//

import UIKit
import RxSwift

class ColorPickerViewController: UEViewController<AppCoordinator> {
    
    let disposeBag = DisposeBag()
    
    // MARK: UI
    
    let currentColorView = ColorPickerPreviewCircle()
    let pickerView: ColorPickerView = {
        let pickerView = ColorPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    // MARK: - Setup
    
    override func setupUI() {
        title = "Color Picker"
        view.backgroundColor = .systemBackground
        setupCurrentColorView()
        setupPickerView()
    }
    
    private func setupCurrentColorView() {
        currentColorView.backgroundColor = .white
        view.addSubview(currentColorView)
        currentColorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0).isActive = true
        currentColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentColorView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
    }
    
    private func setupPickerView() {
        view.addSubview(pickerView)
        pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 280.0).isActive = true
    }
    
    override func bindUI() {
        pickerView.rx.value
            .map({ $0.uiColor })
            .bind(to: currentColorView.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
}
