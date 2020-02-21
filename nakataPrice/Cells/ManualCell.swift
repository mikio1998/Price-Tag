//
//  ManualCell.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 2/14/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit


class ManualNameCell: UITableViewCell {

    @IBOutlet weak var manualName: UILabel!
    @IBOutlet weak var manualPlaceholder: UITextField!
    
    func setLabels(label:ManualCells) {
        manualName.text = label.name
        manualPlaceholder.placeholder = label.placeholder
    }
      
    // Func that reads textfield inputs when called upon.
    // Fills the info into Product class, and returns the Product class.
    // This is for the Save button.
//    func readInputs(label:ManualCells) {
//        //var name: String = label.name
//
//        var placeholder: String = label.placeholder
//
//        let newManual = Product(name: placeholder, brand: <#T##String#>, size: <#T##String#>, color: String, price: "0", id: <#T##String#>, quantity: 1)
//
//    }
    
    
    
    
}
    

//class ManualBrandCell: UITableViewCell {
//
//}
