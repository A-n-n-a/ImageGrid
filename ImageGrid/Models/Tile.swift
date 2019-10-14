//
//  Tile.swift
//  ImageGrid
//
//  Created by Anna on 10/14/19.
//  Copyright © 2019 Anna. All rights reserved.
//

import UIKit
import CoreImage

class Tile {
    var image: CGImage
    var mainColor: UIColor? {
        let uiImage = UIImage(cgImage: image)
        return uiImage.averageColor
    }
    
    init(image: CGImage) {
        self.image = image
        
    }
}
