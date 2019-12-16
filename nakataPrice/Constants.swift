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
    
    var price: Int
    
    init(name: String, brand: String, size: String, color: String, price: Int) {
        self.name = name
        self.brand = brand
        self.size = size
        self.color = color
        self.price = price
    }
}
