//
//  TransitionDestinationViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 19/04/24.
//

import UIKit

class TransitionDestinationViewController: UEViewController<TransitionsCoordinator> {
    
    // MARK: Props
    
    let transitionType: TransitionType
    
    // MARK: UI
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, UIView(), buttonStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40.0
        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton, nextButton])
        stackView.spacing = 16.0
        return stackView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Press \"Next\" to continue\nor \"Previous\" to go back"
        return label
    }()
    
    lazy var previousButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Previous"
        button.configuration = configuration
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Next"
        button.configuration = configuration
        return button
    }()
    
    // MARK: - Life cycle
    
    init(transitionType: TransitionType) {
        self.transitionType = transitionType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    override func setupUI() {
        title = "Flip Transition"
        view.backgroundColor = .secondarySystemBackground
        setupStackView()
        setupButtonActions()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupButtonActions() {
        previousButton.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func previousButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    /// Override point with navigation purpose.
    @objc func nextButtonAction(_ sender: UIButton) {
        coordinator?.performRoute(for: transitionType)
    }
}
