//
//  TransitionsViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 18/04/24.
//

import UIKit

class TransitionsViewController: UEViewController<TransitionsCoordinator> {
    
    // MARK: Props
    
    fileprivate static let cellReuseIdentifier = "TransitionsCell"
    private let pushItems: [TransitionItemData] = [
        TransitionItemData(type: .crossDissolve, text: "Cross Dissolve"),
        TransitionItemData(type: .flip, text: "Flip"),
        TransitionItemData(type: .pageCurl, text: "Page Curl"),
    ]
    private let presentItems: [TransitionItemData] = [
        TransitionItemData(type: .crossDissolve, text: "Cross Dissolve"),
        TransitionItemData(type: .flip, text: "Flip"),
        TransitionItemData(type: .pageCurl, text: "Page Curl"),
    ]
    
    // MARK: UI
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TransitionsViewController.cellReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Setup
    
    override func setupUI() {
        title = "Transitions"
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension TransitionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: pushItems.count
        case 1: presentItems.count
        default: 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: cellForPushTransition(at: indexPath)
        case 1: cellForPresentTransition(at: indexPath)
        default: UITableViewCell()
        }
    }
    
    private func cellForPushTransition(at indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < pushItems.count else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: TransitionsViewController.cellReuseIdentifier, for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = pushItems[indexPath.row].text
        cell.contentConfiguration = configuration
        return cell
    }
    
    private func cellForPresentTransition(at indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < presentItems.count else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: TransitionsViewController.cellReuseIdentifier, for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = presentItems[indexPath.row].text
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TransitionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: "Push"
        case 1: "Present"
        default: nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        switch indexPath.section {
        case 0: pushTransition(at: indexPath.row)
        case 1: presentTransition(at: indexPath.row)
        default: return
        }
    }
    
    private func pushTransition(at itemIndex: Int) {
        guard itemIndex < pushItems.count else { return }
        let transitionType = pushItems[itemIndex].type
        coordinator?.performRoute(for: transitionType)
    }
    
    private func presentTransition(at itemIndex: Int) {
        guard itemIndex < presentItems.count else { return }
        let transitionType = presentItems[itemIndex].type
        coordinator?.performRoute(for: transitionType, push: false)
    }
}

// MARK: - Item data

struct TransitionItemData {
    let type: TransitionType
    let text: String
}
