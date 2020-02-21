//
//  ManualAdd.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 2/14/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


class ManualAddViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    

    
    // Cancel Button
    // Dismisses the Modal VC
    @IBAction func cancelManual(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
// Access user Input into Manual textfields.
// Save the inputs as new Sale
    @IBAction func saveManual(_ sender: Any) {
        
        let salesTrackDB = Firestore.firestore()
        let salesRef = salesTrackDB.collection("sales track")
        
        var inputs = [String]()
        
        // Get the cells.
        // Should iterate in order.
        for cell in 0..<4 {
            print("b0ss")
            let ndx = IndexPath(row:cell, section: 0)
            let cell = tableView.cellForRow(at: ndx) as! ManualNameCell
            print("\(cell.manualPlaceholder.text!)")
            inputs.append("\(cell.manualPlaceholder.text!)")
        }
        
        
        let newSale =
            Product(name: inputs[0],
                    brand: inputs[1],
                    size: inputs[2],
                    color: inputs[3],
                    price: "0",
                    id: "\(inputs[1])-\(inputs[0])-\(inputs[3])-\(inputs[2])",
                    quantity: 1)
        print(newSale)
        
        // Add new entry to sales track.
        salesRef.document(newSale.id).setData([
            "name": newSale.name,
            "brand": newSale.brand,
            "size": newSale.size,
            "color": newSale.color,
            "price": newSale.price,
            "id": newSale.id,
            "quantity": newSale.quantity
        
        ])
        
        
        
//        salesRef.addDocument(data: [
//            "name": newSale.name,
//            "brand": newSale.brand,
//            "size": newSale.size,
//            "color": newSale.color,
//            "price": newSale.price,
//            "id": newSale.id,
//            "quantity": newSale.quantity
//            ])
        
        // Dismiss modal on tap.
        self.dismiss(animated: true, completion: nil)
    }
    
    // For the table Cells
    let labelArray = ["Name/ID", "Brand", "Color", "Size"]
    let placeholderArray = ["MA-1", "Valley Apparel", "Black", "Small"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// TESTING
//func setLabels(label:ManualCells) {
//    manualLabel.text = label.name
//    manualPlaceholder.placeholder = label.placeholder
//}


extension ManualAddViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Manual Name Cell") as! ManualNameCell
        let field = ManualCells(name: labelArray[indexPath.row], placeholder: placeholderArray[indexPath.row])
        
        cell.setLabels(label: field)
        
        return cell
    }
    
    
}
