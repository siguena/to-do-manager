//
//  SettingsScreenVC.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 28.02.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsScreenVC: UIViewController {
    
    private let center = UNUserNotificationCenter.current()
    
    @IBOutlet weak var noificationSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noificationSwitch.isOn = UserDefaults.standard.bool(forKey: Constants.localStorageEnableNotifications)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(noificationSwitch.isOn, forKey: Constants.localStorageEnableNotifications)
    }
    
    
    private func enableLocalNotifications() {
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (allowed, error) in
            if error == nil {
                if allowed {
                    UserDefaults.standard.set(true, forKey: Constants.localStorageEnableNotifications)
                } else {
                    
                    self.presentAlert(title: "Local notifications", message: "Enable local notifications?", type: .appSettings)
                    // ToDo: Should check return if cancel action is selected and set switch to off
                }
            } else {
                
            }
            
        }
    }
    
    private func disableNotifications() {
        UserDefaults.standard.set(false, forKey: Constants.localStorageEnableNotifications)
    }
    
    @IBAction func didUpdatePreference(_ sender: UISwitch) {
        if sender.isOn {
            enableLocalNotifications()
        } else {
            disableNotifications()
        }
    }
    
}
