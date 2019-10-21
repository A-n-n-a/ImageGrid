//
//  ViewController.swift
//  ImageGrid
//
//  Created by Anna on 10/14/19.
//  Copyright © 2019 Anna. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tiles = [Tile]()
    
    var image: CGImage?
    let times = 30
    var width: Int?
    var height: Int?
    var cellWidth: CGFloat?
    
    var action = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MatrixCell", bundle: nil)

        collectionView.register(nib, forCellWithReuseIdentifier: "MatrixCell")
        
        image = imageView.image?.cgImage
        if let image = image {
            width = image.width / times
            height = image.height / times
        }
        cellWidth = (UIScreen.main.bounds.width - 60) / CGFloat(times)
    }

    @IBAction func split(_ sender: Any) {
        switch action {
        case 0:
            splitImage()
        default:
            collectionView.reloadData()
        }
        
        action += 1
    }
    
    func splitImage() {
        guard let width = width else { return }
        let intWidth = Int(width)
        
        for y in 0..<times {
            for x in 0..<times {
                if let croppedImage = image?.cropping(to: CGRect(x: x * intWidth, y: y * intWidth, width: intWidth, height: intWidth)) {
                    let tile = Tile(image: croppedImage)
                    tiles.append(tile)
                }
            }
        }
        
        collectionView.isHidden = tiles.isEmpty
        collectionView.reloadData()
    }
    
    func getColorsArray() {
//        DispatchQueue.global(qos: .background).async {
//            let hexArray = self.tiles.compactMap({ (tile) -> String? in
//                print(tile.mainColor?.hexString)
//                return tile.mainColor?.hexString
//            })
//
//            //remove duplications
//            let set = Set(hexArray)
//            let uniqueSortedArray = Array(set).sorted()
//
//            DispatchQueue.main.async {
//                self.getMainColors(from: uniqueSortedArray)
//            }
//        }
        
        collectionView.reloadData()
    }
    
    func getMainColors(from array: [String]) {
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MatrixCell.self), for: indexPath) as! MatrixCell
        cell.tile = tiles[indexPath.item]
        cell.width = cellWidth
        cell.action = action
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let width = cellWidth {
            return CGSize(width: width, height: width)
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
