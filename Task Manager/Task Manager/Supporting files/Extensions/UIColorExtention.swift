//
//  UIColorExtention.swift
//  Task Manager
//
//  Created by Vladimir Milushev on 1.03.19.
//  Copyright © 2019 siguena. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hexColor: String) {
        let r, g, b, a: CGFloat
        let hexInt = UIColor.intFromHexString(hexString: hexColor)
        
        if UIColor.containsAlpha(hexColor: hexColor) {
            r = CGFloat((hexInt & 0xff000000) >> 24) / 255
            g = CGFloat((hexInt & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexInt & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexInt & 0x000000ff) / 255
        } else {
            r = CGFloat((hexInt & 0xff0000) >> 16) / 255
            g = CGFloat((hexInt & 0x00ff00) >> 8) / 255
            b = CGFloat(hexInt & 0x0000ff) / 255
            a = CGFloat(1)
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    private static func containsAlpha(hexColor: String) -> Bool {
        let elementCount = getHexElementCount(hexValue: hexColor)
        return elementCount == 8
    }
    
    private static func getHexElementCount(hexValue: String) -> Int {
        let containsPrefix = hexValue.hasPrefix("#")
        var elementCount = hexValue.count
        
        if (containsPrefix) {
            elementCount = elementCount - 1
        }
        
        return elementCount
    }
    
    private static func intFromHexString(hexString: String) -> UInt64 {
        var hexInt: UInt64 = 0
        
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt64(&hexInt)
        
        return hexInt
    }
    
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
}
