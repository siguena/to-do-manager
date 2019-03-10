//
//  TaskDetailsScreenVC.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 28.02.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

class TaskDetailsScreenVC: UIViewController, ColourPaletteDelegate {
   
    @IBOutlet weak var titleTextField: TaskNameTextView!
    @IBOutlet weak var categoryTextField: TaskCategoryTextField!
    @IBOutlet weak var dueDateTextField: TaskDatePicker!
    @IBOutlet weak var categoryColour: UIView!
    @IBOutlet weak var categoryPalette: TaskColourPalette!
    
    public var currentTask: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        categoryPalette.delegate = self
        categoryColour.backgroundColor = UIColor(hexColor: Constants.colourFallBackColour)
        
        setupNavigationView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupTask()
    }
    
    
    private func setupTask() {
        if currentTask != nil {
            titleTextField.text = currentTask?.title
            if let categoryName = currentTask?.category?.name {
                self.categoryTextField.text = categoryName
            }
            if let date = currentTask?.completionDate?.asString {
                dueDateTextField.text = date
            }
            
        } else {

            titleTextField.text = ""
            categoryTextField.text = ""
            dueDateTextField.text = ""
        }
    }
    
    
    private func setupNavigationView() {
        let deleteBtn = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTask))
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        
        navigationItem.rightBarButtonItems = [deleteBtn, saveBtn]
    }
    
    
    func didSelectColour(_ color: UIColor) {
        categoryColour.backgroundColor = color
    }
    
    
    @objc private func deleteTask() {
        guard let task = currentTask else {
            return
        }
        
        presentAlert(title: "Remove task?", message: "Are you sure you want to remove task?", type: .deleteTask(taskID: task.id))
        
    }
    
    @objc private func saveTask() {
        
        if validateFields() {
            PersistentStorageManager.shared.saveTask(with: currentTask?.id, title: titleTextField.text!, date: dueDateTextField.text?.asDate, categoryName: categoryTextField.text!)
            
            navigationController?.popViewController(animated: true)
            
        } else {
            
            presentAlert(title: "Empty fields", message: "Please fill all empty fields and try again", type: .information)
        }
    }
    
    private func validateFields() -> Bool {
        if titleTextField.text != "" && categoryTextField.text != "" {
            return true
        } else {
            return false
        }
    }
}
