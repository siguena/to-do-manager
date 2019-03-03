//
//  TaskCategoryTextField.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 2.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

class TaskCategoryTextField: UITextField, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate  {
    
    private let categoryPicker = UIPickerView()
    private var categories: [Category] = []
    private var selectedCategory: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupPicker()
    }
    
    
    private func setupPicker(){
        categories = PersistentStorageManager.shared.loadCategories()
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        self.delegate = self
        
        self.inputView = categoryPicker
        self.tintColor = .clear
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmissPicker))
        
        toolBar.items = [btnDone]
        
        self.inputAccessoryView = toolBar
    }
    
    
    @objc private func dissmissPicker() {
        self.text = selectedCategory
        self.resignFirstResponder()
    }
    
    // Text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    
    // Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row == 0 ? "" : categories[row - 1].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCategory = row == 0 ? "" : categories[row - 1].name ?? ""
    }

}


