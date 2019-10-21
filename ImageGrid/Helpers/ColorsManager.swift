//
//  ColorsManager.swift
//  ImageGrid
//
//  Created by Anna on 10/15/19.
//  Copyright © 2019 Anna. All rights reserved.
//

import Foundation
import UIKit

class ColorsManager {
    
    static var totalHexColors = [String]()
    
    static var mainColors: [String] {
        //remove duplications
        let set = Set(totalHexColors)
        let uniqueSortedArray = Array(set).sorted()
        
        var outputArray = [String]()
        let step = uniqueSortedArray.count / 7
        var appendedIndex = 0
        for (index, hex) in uniqueSortedArray.enumerated() {
            if index == 0 {
                outputArray.append(hex)
            } else if index == (appendedIndex + step) {
                outputArray.append(hex)
                appendedIndex += step
            }
        }
        print(outputArray)
        return outputArray
    }
    
    static func closestColor(hex: String) -> UIColor {
        var minDifferense = 0
        var closestHex = ""
        for color in mainColors {
            if let differense = color - hex {
                print(differense)
                if minDifferense == 0 {
                    minDifferense = differense
                } else if abs(differense) < abs(minDifferense) {
                    minDifferense = differense
                    closestHex = color
                }
            }
        }
        return closestHex.uiColor()
    }
}
