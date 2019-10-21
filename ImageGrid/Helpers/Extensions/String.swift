//
//  String.swift
//  ImageGrid
//
//  Created by Anna on 10/15/19.
//  Copyright © 2019 Anna. All rights reserved.
//

import UIKit

extension String {
    static func -(first: String, second: String) -> Int? {
        var differense = 0
        var power = Int(truncating: NSDecimalNumber(decimal: pow(10, first.count)))
        guard first.count == second.count else { return nil }
        for index in 0..<first.count {
            
            if first[index] > second[index] {
                differense += power
            } else if first[index] < second[index] {
                differense -= power
            }
            power /= 10
        }
        return differense
    }
    
    subscript (i: Int) -> Character {
      return self[index(startIndex, offsetBy: i)]
    }
    
    func uiColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
