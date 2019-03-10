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
        } 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            selectedTask = dataManager.item(at: indexPath.row, in: .pending)
            performSegue(withIdentifier: Constants.segueTaskDetails, sender: self)
        default:
            selectedTask = dataManager.item(at: indexPath.row, in: .completed)
            presentAlert(title: "Completed!", message: "Task is completed", type: .information)
        }
        
        taskTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            switch indexPath.section {
                
            case 0:
                self.dataManager.delete(at: indexPath.row, in: .pending)
                self.taskTableView.deleteRows(at: [indexPath], with: .fade)
            default:
                self.dataManager.delete(at: indexPath.row, in: .completed)
                self.taskTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        let doneAction = UITableViewRowAction(style: .normal, title: "Done") { (action, indexPath) in
            
            self.dataManager.completeTask(at: indexPath.row)
            self.taskTableView.reloadData()
        }
        
        switch indexPath.section {
        case 0:
            return [deleteAction, doneAction]
        default:
             return [deleteAction]
        }
        
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

