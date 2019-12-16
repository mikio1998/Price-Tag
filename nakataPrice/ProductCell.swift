//
//  ProductCell.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 12/15/19.
//  Copyright © 2019 Mikio Nakata. All rights reserved.
//

// Product Cell (For tableview)
//

import UIKit

class productCell: UITableViewCell {
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var brandProduct: UILabel!
    @IBOutlet weak var sizeProduct: UILabel!
    @IBOutlet weak var colorProduct: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    // For convenience
    // When setting the cell's properties...
    func setSale(sale:Product) {
        nameProduct.text = sale.name
        brandProduct.text = sale.brand
        sizeProduct.text = sale.size
        colorProduct.text = sale.color
        quantity.text = "Under Construction"
    }
    
}
