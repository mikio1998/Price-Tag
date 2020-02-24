//
//  MenuCell.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 2/24/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit


class MenuViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // Cell Configuration
    // Title, color, active status.
    func configure(title: String, color: UIColor, active: Bool) {
        nameLabel.text = title
        nameLabel.backgroundColor = color
        focusCell(active: active)
    }
    
    
    // Color config when cell is Active.
    // White to Grey.
    func focusCell(active: Bool) {
        let color = active ? UIColor.white : UIColor.lightGray
        nameLabel.textColor = color
        print("ok")
    }
    
}
