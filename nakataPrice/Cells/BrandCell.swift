//
//  BrandCell.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 3/3/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit

class SampleCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var cellLabel: UILabel!
    // Without image
    func setLabelandImage(label: String) {
        cellLabel.text = label
    }
//    func setLabelandImage(label: String, image: UIImage) {
//        cellLabel.text = label
//        cellImage.image = image
//    }
}
