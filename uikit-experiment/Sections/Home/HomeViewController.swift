//
//  HomeViewController.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 17/04/24.
//

import UIKit

class HomeViewController: UEViewController<AppCoordinator> {
    
    // MARK: Props
    
    fileprivate static let cellReuseIdentifier = "HomeCell"
    private let items: [HomeCellData] = [
        HomeCellData(item: .colorPicker, text: "Color Picker")
    ]
    
    // MARK: UI
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: HomeViewController.cellReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Setup
    
    override func setupUI() {
        title = "Home"
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Navigation
    
    fileprivate func performRoute(for item: HomeItem) {
        switch item {
        case .colorPicker: coordinator?.presentColorPicker()
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < items.count else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.cellReuseIdentifier, for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = items[indexPath.row].text
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        guard indexPath.row < items.count else { return }
        performRoute(for: items[indexPath.row].item)
    }
}

// MARK: - Home Items

enum HomeItem: CaseIterable {
    case colorPicker
}

struct HomeCellData {
    let item: HomeItem
    let text: String
}
