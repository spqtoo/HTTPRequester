//
//  SettingsViewController.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 28.10.2022.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        
    }
    
    private func configureNavBar() { navigationItem.title = "Настройки" }
    
    private func configureView() {
        view.backgroundColor = R.color.controllers_bg()
    }
}
