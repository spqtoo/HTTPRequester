//
//  MainTabBarController.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 27.10.2022.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    enum TabBarItem: Int {
        case requests
        case projects
        case settings
    
        var title: String {
            switch self {
            case .requests:
                return "Запросы"
            case .projects:
                return "Проекты"
            case .settings:
                return "Настройки"
            }
        }
        
        var iconName: String {
            switch self {
            case .requests:
                return "arrow.up.arrow.down"
            case .projects:
                return "briefcase"
            case .settings:
                return "gear"
            }
        }

    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
            return UINavigationController(rootViewController: with)
        }
    
    private func setupTabBar() {
        
        let dataSource: [TabBarItem] = [.requests, .projects,.settings]
        
        viewControllers = dataSource.compactMap {
            switch $0 {
            case .requests:
                let requestsViewController = QuickRequestsViewController()
                return self.wrappedInNavigationController(with: requestsViewController, title: $0.title)
            case .projects:
                let projectsViewController = ProjectsViewController()
                return self.wrappedInNavigationController(with: projectsViewController, title: $0.title)
            case .settings:
                let settingsViewController = SettingsViewController()
                return self.wrappedInNavigationController(with: settingsViewController, title: $0.title)
            }
        }
        
        viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().barTintColor = .clear
//        UINavigationBar.appearance().backgroundColor = .lightGray
        
    }
    
    
}
