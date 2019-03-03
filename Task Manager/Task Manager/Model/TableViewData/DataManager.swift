//
//  DataManager.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 1.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import Foundation


public class DataManager {
    
    public var data: [Task] { return
        PersistentStorageManager.shared.loadTasks()
    }
    
    public var itemCount: Int {
        return data.count
    }
    
    
    public func item(at index: Int) -> Task {
        return data[index]
    }
    
//    public func add(item: Item) {
//        data.append(item)
//    }
    
//    public func delete(at index: Int) {
//        data.remove(at: index)
//    }
    
}
