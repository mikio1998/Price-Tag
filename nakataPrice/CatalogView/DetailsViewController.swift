//
//  DetailsViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 3/11/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class DetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    var brand : String = ""
    var name : String = ""
    var price : String = ""
    var color : String = ""
    
    // create dict to get every product
    
    
    
    var pickerData = [["color", "color", "color", "color"],
                      ["size", "size", "size", "size"],
                      ["quantity", "quantity", "quantity", "quantity"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        print("BACK")
        self.nameLabel.text = self.name
        self.brandLabel.text = self.brand
        
    }
    
    // MARK: Reading data from Firestore
    // Need to get product's available SIZES, COLORS.
    
    // Filter by BRAND --> Filter by NAME
    // --> algo for getting all names, colors.

    func firestoreToArray(brand: String, name: String) {
        let firestoreDB = Firestore.firestore()

        // Filter by name
        let productsDB = firestoreDB.collection("products").whereField("name", isEqualTo: self.name)
    }
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    // Count of picker column
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    // Capture the picker selection view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Triggered when user makes change to picker collection.
        // Parameters named row and component determines what was selected.
    }
    
}
