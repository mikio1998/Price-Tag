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
        (menuTitle: "Alpha Industres", content: "コンテンツ1", themeColor: UIColor.red),
        (menuTitle: "Avirex", content: "コンテンツ2", themeColor: UIColor.green),
        (menuTitle: "Valley Apparel", content: "コンテンツ3", themeColor: UIColor.purple),
        (menuTitle: "Helikon Tex", content: "コンテンツ4", themeColor: UIColor.yellow),
        (menuTitle: "TRU-SPEC", content: "コンテンツ5", themeColor: UIColor.cyan),
        (menuTitle: "Sessler", content: "コンテンツ6", themeColor: UIColor.orange),
        (menuTitle: "Morgan", content: "コンテンツ6", themeColor: UIColor.brown),
        (menuTitle: "J-TECH", content: "コンテンツ6", themeColor: UIColor.darkGray),
        (menuTitle: "Bates", content: "コンテンツ6", themeColor: UIColor.magenta),
        (menuTitle: "Rothco", content: "コンテンツ6", themeColor: UIColor.red),
    ]
}
