//
//  MainScreenVC.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 28.02.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    private var selectedTask: Task?
    private var dataManager = DataManager()
    private lazy var dataSourceProvider = TaskTableDataSource(dataManager: dataManager)
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        
        taskTableView.delegate = self
        taskTableView.dataSource = dataSourceProvider
    }
    
    override func viewDidAppear(_ animated: Bool) {
        taskTableView.reloadData()
    }
    
    private func setupUI() {
        setupNavigationView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.segueTaskDetails {
            if let vc = segue.destination as? TaskDetailsScreenVC {
                
              vc.currentTask = selectedTask
            }
        } else if segue.identifier == Constants.segueSettings{
            if let vc = segue.destination as? SettingsScreenVC {
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = dataManager.item(at: indexPath.row)
        performSegue(withIdentifier: Constants.segueTaskDetails, sender: self)
        
        taskTableView.deselectRow(at: indexPath, animated: true)
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
            
            selectedTask = nil
            performSegue(withIdentifier: Constants.segueTaskDetails, sender: self)
        }
    }
}

