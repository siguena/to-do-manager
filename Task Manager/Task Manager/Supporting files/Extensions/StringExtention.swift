//
//  StringExtention.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 3.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import Foundation

extension String {
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormatString
        return formatter
    }()
    
    var asDate: Date? {
        guard let date = String.formatter.date(from: self) else { return nil }
        return date
    }
    
}
