//
//  MainScreenVC.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 28.02.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationView()
    }
    
    private func setupNavigationView() {
         let settingsBtn = UIBarButtonItem(image: UIImage(named: "nav_bar_ic_settings"), style: .plain, target: self, action: #selector(navigateToScreen))
        settingsBtn.tag = 1
        
        let taskDetailsBtn = UIBarButtonItem(image: UIImage(named: "nav_bar_ic_add"), style: .plain, target: self, action: #selector(navigateToScreen))
        taskDetailsBtn.tag = 2
        
        
        navigationItem.rightBarButtonItem = settingsBtn
        navigationItem.leftBarButtonItem = taskDetailsBtn
    }
    
    
    @objc private func navigateToScreen(_ sender: UIBarButtonItem) {
        if sender.tag == 1 {
            performSegue(withIdentifier: Constants.segueSettings, sender: self)
        } else {
            performSegue(withIdentifier: Constants.segueTaskDetails, sender: self)
        }
    }
}

