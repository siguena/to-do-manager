//
//  DataManager.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 1.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import Foundation


public enum SectionType {
    case completed, pending
}

public class DataManager {
    
    public var pendingTasks: [Task] { return
        PersistentStorageManager.shared.loadTasks()
    }
    
    public var completedTasks: [Task] {
        return PersistentStorageManager.shared.loadTasks(byID: nil, isCompleted: true)
    }
    
    
    public func getItemCount(in section: SectionType) -> Int {
        switch section {
        case .completed:
            return completedTasks.count
        case .pending:
            return pendingTasks.count
        }
    }
    
    
    public var itemCount: Int {
        return pendingTasks.count
    }
    
    
    public func item(at index: Int, in section: SectionType) -> Task {
        switch section {
        case .completed:
            return completedTasks[index]
        case .pending:
            return pendingTasks[index]
        }
    }
    
    
    public func delete(at index: Int, in section: SectionType) {
        switch section {
        case .completed:
            PersistentStorageManager.shared.deleteTask(id: completedTasks[index].id)
        case .pending:
            PersistentStorageManager.shared.deleteTask(id: pendingTasks[index].id)
        }
    }
    
    public func completeTask(at index: Int) {
        PersistentStorageManager.shared.setCompleted(taskId: pendingTasks[index].id)
    }
    
}
