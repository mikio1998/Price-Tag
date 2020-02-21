//
//  Constants.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 12/16/19.
//  Copyright © 2019 Mikio Nakata. All rights reserved.
//

import Foundation


class Product {
    var name: String
    var brand: String
    var size: String
    var color: String
    
    var price: String
    var id: String
    var quantity: Int
    
    init(name: String, brand: String, size: String, color: String, price: String, id: String, quantity: Int) {
        self.name = name
        self.brand = brand
        self.size = size
        self.color = color
        self.price = price
        self.id = id
        self.quantity = quantity
    }
}

// For Label and Placeholder for Manual tableView Cells. 
class ManualCells {
    var name: String
    var placeholder: String
    
    init(name: String, placeholder: String) {
        self.name = name
        self.placeholder = placeholder
    }
    
}
