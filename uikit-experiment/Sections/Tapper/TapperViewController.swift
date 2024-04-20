//
//  TapperViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 20/04/24.
//

import UIKit
import RxSwift

class TapperViewController: UEViewController<AppCoordinator> {
    
    // MARK: Props
    
    let viewModel: TapperViewModelProtocol
    let disposeBag = DisposeBag()
    
    // MARK: UI
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life cycle
    
    init(viewModel: TapperViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    override func setupUI() {
        view.backgroundColor = .systemBackground
        setupLabel()
    }
    
    private func setupLabel() {
        view.addSubview(counterLabel)
        counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        counterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func bindUI() {
        bindGesture()
        bindLabel()
    }
    
    private func bindGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.rx.event
            .map({ _ in () })
            .bind(to: viewModel.increment)
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapGesture)
    }
    
    private func bindLabel() {
        viewModel.counter
            .map({ "\($0)" })
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
