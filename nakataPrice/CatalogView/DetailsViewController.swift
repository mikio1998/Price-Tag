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
    
//    var sizeArray: [String] = []
//    var colorArray: [String] = []
    
//    var pickerData = [["color", "color", "color", "color"],
//                      ["size", "size", "size", "size"],
//                      ["quantity", "quantity", "quantity", "quantity"]]
    
    var pickerData: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firestoreToArray(brand: self.brand, name: self.name)
        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.nameLabel.text = self.name
        self.brandLabel.text = self.brand
        
//        firestoreToArray(brand: self.brand, name: self.name)
        
    }
    
    // MARK: Reading data from Firestore
    // Need to get product's available SIZES, COLORS.
    
    // Filter by BRAND --> Filter by NAME
    // --> algo for getting all names, colors.

    
    func firestoreToArray(brand: String, name: String) {
        let firestoreDB = Firestore.firestore()
        
//        let sizeArray = []
//        let colorArray = []
        var sizeArray: [String] = []
        var colorArray: [String] = []

        // Filter by both product BRAND and NAME
        // Use brand, to prevent same-name-diff-brand risk.
        let productsDB = firestoreDB.collection("products").whereField("brand", isEqualTo: self.brand).whereField("name", isEqualTo: self.name)
        
        // You have every type of the Product, here.
        productsDB.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // Get the sizes and colors.
                for document in querySnapshot!.documents {
                    
                    // Instantiate document's product size.
                    let sizeInstance = document.get("size") as! String
                    
                    let colorInstance = document.get("color") as! String

                    
                    //if self.sizeArray.contains(sizeInstance) {
                    if sizeArray.contains(sizeInstance) {
                        // If it contains, do nothing.
                    } else {
//                        self.sizeArray.append(sizeInstance)
                        sizeArray.append(sizeInstance)
                    }
                    
//                    if self.colorArray.contains(colorInstance) {
                    if colorArray.contains(colorInstance) {
                        // If it contains, do nothing.
                    } else {
//                        self.colorArray.append(colorInstance)
                        colorArray.append(colorInstance)
                    }
                }
                
                // Dammn, I just spent a week solving this problem... one line.
                //self.collectionView.reloadData()
            }
            self.pickerData.append(sizeArray)
            self.pickerData.append(colorArray)
            
            print(self.pickerData)

        }

    }
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print(pickerData.count)
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
