//
//  SalesViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 12/15/19.
//  Copyright © 2019 Mikio Nakata. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class SalesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var salesArray: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        firestoreToArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    // Populating the salesArray with DB documents.
    func firestoreToArray() {
        let salesTrackDB = Firestore.firestore()
        let salesRef = salesTrackDB.collection("sales track")
        
        
        salesRef.getDocuments { (document, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                // "get" document Fields.
                for document in document!.documents {
                    
                    //accessing fields of document
                    let Name = document.get("name") as! String
                    let Brand = document.get("brand") as! String
                    let Size = document.get("size") as! String
                    let Color = document.get("color") as! String
                    let Price = document.get("price") as! String

                    // Document Fields converted to my Product Class.
                    let tempSale = Product(name: Name, brand: Brand, size: Size, color: Color, price: Price)
                    //append Food to array
                    self.salesArray.append(tempSale)
                }
                self.tableView.reloadData()
            }
        }
    }
}

// Make the tableView!
extension SalesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell") as! productCell
        
        let sale = salesArray[indexPath.row]
        cell.setSale(sale: sale)
        return cell
    }
    
}

