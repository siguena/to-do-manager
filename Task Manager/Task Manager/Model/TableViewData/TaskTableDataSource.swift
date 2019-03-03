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
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.itemCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierTaskCell, for: indexPath) as! TaskViewTableViewCell
        
        cell.setupCell(task: dataManager.data[indexPath.row])
       
        return cell
    }
    
    
}
