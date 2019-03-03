//
//  TaskDatePicker.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 2.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

class TaskDatePicker: UITextField, UITextFieldDelegate {
    
    private let datePicker = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        
        // Date Picker
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        
       
        // TextField
        self.delegate = self
        self.tintColor = .clear
        self.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmissPicker))
        
        toolBar.items = [btnDone]
        
        self.inputAccessoryView = toolBar
    }
    
    @objc private func handlePickedDate(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormatString
    
        self.text = formatter.string(from: sender.date)
    }
    
    @objc private func dissmissPicker() {
        datePicker.removeTarget(self, action: #selector(handlePickedDate), for: .valueChanged)
        self.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.addTarget(self, action: #selector(handlePickedDate), for: .valueChanged)
    }
}
