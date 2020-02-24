//
//  Constants.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 12/16/19.
//  Copyright © 2019 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit


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


// menu tab class
class MenuTab {
    var title: String
    var content: String
    var color: UIColor
    
    init(title: String, content: String, color: UIColor) {
        self.title = title
        self.content = content
        self.color = color
    }
}



// Shop Menu sample data
class ViewModelManager {
    typealias ViewModel = (menuTitle: String, content: String, themeColor: UIColor)

    static let sharedInstance = ViewModelManager()
    
    
    let data: [ViewModel] = [
        (menuTitle: "Menu-1", content: "コンテンツ1",  themeColor: UIColor.red),
        (menuTitle: "メニュー2", content: "コンテンツ2",  themeColor: UIColor.green),
        (menuTitle: "メニュー3", content: "コンテンツ3",  themeColor: UIColor.purple),
        (menuTitle: "メニュー4", content: "コンテンツ4",  themeColor: UIColor.yellow),
        (menuTitle: "メニュー5", content: "コンテンツ5",  themeColor: UIColor.cyan),
        (menuTitle: "メニュー6", content: "コンテンツ6",  themeColor: UIColor.orange),
    ]
}
