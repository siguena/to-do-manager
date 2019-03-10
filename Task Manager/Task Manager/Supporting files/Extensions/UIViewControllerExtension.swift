//
//  UIViewControllerExtension.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 10.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit


public enum AlertType {
    case information
    case deleteTask(taskID: Int32)
    case appSettings
}
extension UIViewController {
    
    func presentAlert(title: String, message: String, type: AlertType) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        switch type {
        case .information:
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
        case .deleteTask(let taskID):
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                PersistentStorageManager.shared.deleteTask(id: taskID)
                self.navigationController?.popViewController(animated: true)
            }))
        
        case .appSettings:
            alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))
            
            let settingsAction = UIAlertAction(title: "Yes", style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                }
            }
            alert.addAction(settingsAction)
        }
        
        self.present(alert, animated: true)
    }
}


