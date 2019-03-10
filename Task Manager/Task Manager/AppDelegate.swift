//
//  AppDelegate.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 28.02.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initialAppSetup()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Check if authorization is change from settings
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                UserDefaults.standard.set(true, forKey: Constants.localStorageEnableNotifications)
            } else {
                UserDefaults.standard.set(false, forKey: Constants.localStorageEnableNotifications)            }
        }
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
        if UserDefaults.standard.bool(forKey: Constants.localStorageEnableNotifications) {
            scheduleNotifications()
        } else {
            clearNotifications()
        }
        
        
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Task_Manager")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func initialAppSetup() {
        guard UserDefaults.standard.string(forKey: "isAppFirstLoad") == nil else { return }
        
            // Initial save default categories in persistent storage
            PersistentStorageManager.shared.createInitialCategories()
        
            // Init sorage for task ids
            UserDefaults.standard.set(0, forKey: "lastTaskId")
        
            UserDefaults.standard.set("notInitialLoad", forKey: "isAppFirstLoad")
    }
    
    
    private func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        // Get all task with dueDate tommorrow
        let tasks = PersistentStorageManager.shared.loadTasks(byID: nil, isCompleted: false, byDate: Date.offsetCurrentDate(by: 2))
        
        for task in tasks {
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Notification", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: task.title!, arguments:nil)
            content.sound = .default
            
            
            var dateInfo = DateComponents()
            // Notifications are scheduled each day at 9:00
            dateInfo.hour = 9
            dateInfo.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
            
            let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger: trigger)
            
            
            center.add(request, withCompletionHandler: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            })
            
        }
        
    }
    
    private func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

}

