//
//  TaskNameTextView.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 2.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit


class TaskNameTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        setupUI()
    }
    
    private func setupUI() {
        self.textColor = .lightGray
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.cornerRadius = 6
        self.textColor = .black
    }
}
