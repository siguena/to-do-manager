//
//  DateExtention.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 2.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import Foundation

extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormatString
        return formatter
    }()
    
    var asString: String {
        return Date.formatter.string(from: self)
    }
    
    
    static func offsetCurrentDate(by days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: Date())!
    }
}

