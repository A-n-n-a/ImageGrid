//
//  MatrixCell.swift
//  ImageGrid
//
//  Created by Anna on 10/14/19.
//  Copyright © 2019 Anna. All rights reserved.
//

import UIKit

class MatrixCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    var action = 1 {
        didSet {
            switch action {
            case 1:
                fillWithTile()
            case 2:
                fillImageWithColor()
            default:
                fillImageWithClosestColor() 
            }
        }
    }
    
    var tile: Tile?
    var width: CGFloat? {
        didSet {
            guard let width = width else { return }
            imageWidth.constant = width
            imageHeight.constant = width
        }
    }
    
    var indexPath: IndexPath?
    
    func fillWithTile() {
        guard let image = tile?.image else { return }
        let uiImage = UIImage(cgImage: image)
        imageView.image = uiImage
    }

    func fillImageWithColor() {
        guard let cgImage = tile?.image else { return }
        let image = UIImage(cgImage: cgImage)
//        DispatchQueue.global(qos: .default).async {
            if let color = image.averageColor {
                if let hex = color.hexString {
                    ColorsManager.totalHexColors.append(hex)
                }
                let colorImage = UIImage(color: color)
//                DispatchQueue.main.async {
                    self.imageView.image = colorImage
//                }
            }
//        }
    }
    
    func fillImageWithClosestColor() {
        guard let indexPath = indexPath else { return }
        let currentHex = ColorsManager.totalHexColors[indexPath.item]
        
        let newColor = ColorsManager.closestColor(hex: currentHex)
        let colorImage = UIImage(color: newColor)
        self.imageView.image = colorImage
    }
}
