//
//  TaskTableDataSource.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 1.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

class TaskTableDataSource: NSObject, UITableViewDataSource {
    
    private let dataManager: DataManager
    private let numberOfSection = 2
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return dataManager.getItemCount(in: .pending)
        default:
            return dataManager.getItemCount(in: .completed)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TaskViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierTaskCell) as! TaskViewTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.setupCell(task: dataManager.pendingTasks[indexPath.row])
        default:
            cell.setupCell(task: dataManager.completedTasks[indexPath.row])
        }
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return Constants.tableViewSectionNamePending
        default:
            return Constants.tableViewSectionNameCompleted
        }
    }
    
}
