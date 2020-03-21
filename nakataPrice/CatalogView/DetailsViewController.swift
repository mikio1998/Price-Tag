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
    

    // save
    @IBAction func save(_ sender: Any) {
    
        var brandName: String = "brand"
        var quantity: Int = Int(self.currentSelection[2]) ?? 1
        
        // Naming adjustment for writing to DB.
        if self.brand == "HELIKON-TEX" {
            brandName = "hk"
        } else if self.brand == "Alpha Industries" {
            brandName = "alpha"
        } else {
            brandName = "brandname"
        }
        
        // Preparing new DB entry ID. Adjusting for proper DB format.
        let newSaleID = brandName.replacingOccurrences(of: " ", with: "")     // brand
            + "-" + "\(self.name.lowercased().replacingOccurrences(of: " ", with: ""))" // name
            + "-" + "\(self.currentSelection[1].lowercased().replacingOccurrences(of: " ", with: ""))" // color
            + "-" + "\(self.currentSelection[0].lowercased().replacingOccurrences(of: " ", with: ""))" // size
        print(newSaleID)
        
        // Check if newSaleID already exists in Sales Track.
        // If so, just add the quantity.
        let firestoreDB = Firestore.firestore()
        let salesRef = firestoreDB.collection("sales track")
        let existSale = firestoreDB.collection("sales track").document(newSaleID)
        
        
    
            // MARK: Tryna increment quantity.
        existSale.getDocument { (document, error) in
            if let document = document, document.exists {
                // JUST ADD QUANTITY
                print("Sale already exists.")
                //document.data().
                
                
                // Get initial quantity.
                //existSale.updateData(["quantity" : FieldValue.increment(quantity)])
                
                // Add new quantity.
//                existSale.updateData([
//                    "quantity": FieldValue.increment(Int64(quantity))
//                ]) { err in
//                    if let err = err {
//                        print("Error updating document: \(err)")
//                    } else {
//                        print("Document successfully updated")
//                    }
//                }
                
                
            } else { // Fresh DB entry.
                
                let newSale =
                    Product(name: self.name,
                            brand: self.brand,
                            size: self.currentSelection[0],
                            color: self.currentSelection[1],
                            price: self.price,
                            //id: "0",
                            id: newSaleID,
                            quantity: quantity)
                print(newSale)
                
                salesRef.document(newSaleID).setData([
                    "name": newSale.name,
                    "brand": newSale.brand,
                    "size": newSale.size,
                    "color": newSale.color,
                    "price": newSale.price,
                    "id": newSale.id,
                    "quantity": newSale.quantity
                ])
            }
        }
        
//        let newSale =
//            Product(name: self.name,
//                    brand: self.brand,
//                    size: self.currentSelection[0],
//                    color: self.currentSelection[1],
//                    price: self.price,
//                    id: "0",
//                    quantity: quantity)
//        print(newSale)
//
//        salesRef.document(newSaleID).setData([
//            "name": newSale.name,
//            "brand": newSale.brand,
//            "size": newSale.size,
//            "color": newSale.color,
//            "price": newSale.price,
//            "id": newSale.id,
//            "quantity": newSale.quantity
//        ])
        
//        salesRef.document(newSale).setData([
//            "name": self.name,
//            "brand": self.brand,
//            "size": .self.currentSelection[0],
//            "color": self.currentSelection[1],
//            "price": self.price,
//            "id": "0",
//            "quantity": quantity
        
//        ])
        self.dismiss(animated: true) {
            
        }
        
    }
    //cancel
    
    // MARK: BUG: CELL DELETION NOT WORKING
    // RESOLUTION: You need to add the new entry to the SalesView data Array.
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var brand : String = ""
    var name : String = ""
    var price : String = ""
    var color : String = ""
        
    var pickerData: [[String]] = []
    
    // brand-name-color-size
    // Attach brand in later process.
    var currentSelection: [String] = ["Name","Color","Size"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.image = UIImage(named: "\(self.name) \(self.color)", in: Bundle(for: type(of: self)), compatibleWith: nil)
        firestoreToArray(brand: self.brand, name: self.name)
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.nameLabel.text = self.name
        self.brandLabel.text = self.brand
        
//        firestoreToArray(brand: self.brand, name: self.name)
        //self.currentSelection[0] ==
        
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
        let quantityArray: [String] = ["1", "2", "3", "4", "5", "6", "7"]

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
                self.pickerData.append(colorArray)
                self.pickerData.append(sizeArray)
                //self.pickerData.append(colorArray)
                self.pickerData.append(quantityArray)
                
                // Dammn, I just spent a week solving this problem... one line.
                //self.collectionView.reloadData()
                //Calling this method causes the picker view to query the delegate for new data for all components.
                self.picker.reloadAllComponents()
            }
            print(self.pickerData, "picker")
            // Setting initial picker selection.
            self.setCurrentSelection()
        }
    }
    
    
    // Setting initial picker selection.
    func setCurrentSelection () {
        for i in 0..<3 { // range 3
            self.currentSelection[i] = self.pickerData[i][0]
        }
        print("Initial Selection:", currentSelection)
    }

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    // Count of picker column's rows.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    // Capture the picker selection view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        // format -> ["Brand", "Name","Color","Size"]
        self.currentSelection[component] = self.pickerData[component][row]
        print("Current Selection:", self.currentSelection)
    }
}
