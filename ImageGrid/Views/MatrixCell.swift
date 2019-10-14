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
    
    var tile: Tile? {
        didSet {
            guard let image = tile?.image else { return }
            imageView.image = UIImage(cgImage: image)
        }
    }
    var width: CGFloat? {
        didSet {
            guard let width = width else { return }
            imageWidth.constant = width
            imageHeight.constant = width
        }
    }

}
