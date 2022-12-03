//
//  ProjectsViewController.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 28.10.2022.
//

import Foundation
import UIKit

final class ProjectsViewController: UIViewController {
    
    private let model = ProjectsViewControllerModel()
    
    private var projects: [Project] {
        model.getProjects()
    }
    
    private lazy var projectsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProjectsTableViewCell.self, forCellReuseIdentifier: ProjectsTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundView = .init()
        return tableView
    }()
        
    private func configureNavBar() {
        navigationItem.title = "Проекты"

    }
    
    private func configureView() {
        view.backgroundColor = R.color.controllers_bg()
        configureTableView(tableView: projectsTableView)
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

extension ProjectsViewController: UITableViewDelegate {
    
}

extension ProjectsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectsTableViewCell.identifier, for: indexPath) as! ProjectsTableViewCell
        guard projects.indices.contains(indexPath.item) else { return cell }
        cell.setDataInProjectsCell(title: projects[indexPath.row].titleProject, countRequests: projects[indexPath.row].countRequests)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let projVC = UIViewController()
        navigationController?.pushViewController(projVC, animated: true)
    
    }
    
    
}
