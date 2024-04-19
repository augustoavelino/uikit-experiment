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
    private let items: [TransitionItemData] = [
        TransitionItemData(type: .flip, text: "Flip"),
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < items.count else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: TransitionsViewController.cellReuseIdentifier, for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = items[indexPath.row].text
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TransitionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        guard indexPath.row < items.count else { return }
        let transitionType = items[indexPath.row].type
        coordinator?.performRoute(for: transitionType)
    }
}

// MARK: - Item data

struct TransitionItemData {
    let type: TransitionType
    let text: String
}
