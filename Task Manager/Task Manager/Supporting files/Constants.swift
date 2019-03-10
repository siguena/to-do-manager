//
//  Constants.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 28.02.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

public struct Constants {
    
    // Segue identifiers
    static let segueTaskDetails = "ShowTaskDetailsSegue"
    static let segueSettings = "ShowSettingsSegue"
    
    // Reuse Identifiers
    static let reuseIdentifierTaskCell = "TaskCell"
    
    // Category colours
    static let colourTaskVeryLowPriority = "#79A700"
    static let colourTaskLowPriority = "#C6DA02"
    static let colourTaskMediumPriority = "#E2B400"
    static let colourTaskHighPriority = "#F68B2C"
    static let colourTaskVeryHighPriority = "#F5522D"
    static let colourTaskNoPriority = "#FF6E83"
    
    static let colourFallBackColour = "#FFFFFF"
    
    // Date format
    static let dateFormatString = "dd/MM/yyyy"
    
    // Task status tableView section names
    static let tableViewSectionNamePending = "Pending"
    static let tableViewSectionNameCompleted = "Completed"
    
    // Local Storage containers
    static let localStorageEnableNotifications = "enableNotifications"
    
}
