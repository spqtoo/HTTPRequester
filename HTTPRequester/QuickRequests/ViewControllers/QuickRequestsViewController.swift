//
//  QuickRequestsViewController.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 28.10.2022.
//

import Foundation
import UIKit

final class QuickRequestsViewController: UIViewController {
    
    let createRequestVC = CreateNewQuickRequestViewController()
    
    private let quickRequestsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QuickRequestsTableViewCell.self, forCellReuseIdentifier: QuickRequestsTableViewCell.identifier)
        tableView.register(QuickRequestTableViewCreateRequestCell.self, forCellReuseIdentifier: QuickRequestTableViewCreateRequestCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func configureView() {
        view.backgroundColor = R.color.controllers_bg()
        configureTableView(tableView: quickRequestsTableView)
    }
    
    private func configureNavBar() {
        navigationItem.title = "Запросы"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureTableView(tableView table: UITableView) {
        table.delegate = self
        table.dataSource = self
        table.backgroundView = .init()
        view.addSubview(table)

        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        
    }
    
}

extension QuickRequestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let startCell = tableView.dequeueReusableCell(withIdentifier: QuickRequestTableViewCreateRequestCell.identifier, for: indexPath)
                    as? QuickRequestTableViewCreateRequestCell else { return QuickRequestTableViewCreateRequestCell() }
            return startCell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuickRequestsTableViewCell.identifier, for: indexPath)
                    as? QuickRequestsTableViewCell else { return QuickRequestsTableViewCell() }
            return cell
        }
      
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: QuickRequestTableViewHeader.identifier)
//                as? QuickRequestTableViewHeader else { return QuickRequestTableViewHeader() }
//        print("create ", section)
//        tableView.
//        return header
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(createRequestVC, animated: true)
        default:
            print("default")
        }
       
    }
}

extension QuickRequestsViewController: UITableViewDelegate {}
