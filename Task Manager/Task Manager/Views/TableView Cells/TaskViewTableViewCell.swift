//
//  TaskViewTableViewCell.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 1.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

class TaskViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryColourView: UIView!
    @IBOutlet weak var taskNameLbl: UILabel!
    @IBOutlet weak var taskDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(task: Task) {
        categoryColourView.backgroundColor = UIColor(hexColor: task.category!.colour!)
        taskNameLbl.text = task.title
        taskDateLbl.text = task.completionDate?.asString
    }

}
