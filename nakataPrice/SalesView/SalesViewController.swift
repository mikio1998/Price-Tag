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
    
    var refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)

        
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
        print(salesArray)
        
        firestoreToArray()
        
        // CALL sendToDB() when scripting adds to FireStore ->
        sendToDB()
        //tableView.reloadData()
        
        tableView.delegate = self
        tableView.dataSource = self
        //self.tableView.reloadData()
    }
    
    // MARK: Refresh functionality under construction.
    // Code to pull refresh table view
    @objc func refresh(sender:AnyObject) {
        //self.tableView.reloadData()
        
        // Removes animation overlap with UI
        let when = DispatchTime.now() + 0.5 // change to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
    func sendToDB() {
        let productDB = Firestore.firestore()
        
        // blk
        productDB.collection("products").document("hk-urbantacticaltshirt-black-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Black",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-black-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Black",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-black-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Black",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-black-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Black",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        // shad grey
        productDB.collection("products").document("hk-urbantacticaltshirt-shadowgrey-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Shadow Grey",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-shadowgrey-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Shadow Grey",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-shadowgrey-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Shadow Grey",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-shadowgrey-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Shadow Grey",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // ada green
        productDB.collection("products").document("hk-urbantacticaltshirt-adaptivegreen-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Adaptive Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-adaptivegreen-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Adaptive Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-adaptivegreen-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Adaptive Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-adaptivegreen-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Adaptive Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        //olive green
        productDB.collection("products").document("hk-urbantacticaltshirt-olivegreen-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Olive Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-olivegreen-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Olive Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-olivegreen-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Olive Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-olivegreen-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Olive Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // coyote brown
        productDB.collection("products").document("hk-urbantacticaltshirt-coyotebrown-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Coyote Brown",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-coyotebrown-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Coyote Brown",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-coyotebrown-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Coyote Brown",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-coyotebrown-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Coyote Brown",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        //foliage green
        productDB.collection("products").document("hk-urbantacticaltshirt-foliagegreen-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Foliage Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-foliagegreen-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Foliage Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-foliagegreen-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Foliage Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-foliagegreen-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Foliage Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // nnavy
        productDB.collection("products").document("hk-urbantacticaltshirt-navy-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Navy",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-navy-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Navy",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-navy-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Navy",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-navy-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Navy",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        //khaki
        productDB.collection("products").document("hk-urbantacticaltshirt-khaki-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Khaki",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-khaki-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Khaki",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-khaki-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Khaki",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-khaki-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "Khaki",
        "size": "XL",
        "color": "Shadow Grey",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        //jungle green
        productDB.collection("products").document("hk-urbantacticaltshirt-junglegreen-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Jungle Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-junglegreen-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Jungle Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-junglegreen-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Jungle Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-junglegreen-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Jungle Green",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-camogrom-s").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "S",
        "color": "Camogrom",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-camogrom-m").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "M",
        "color": "Camogrom",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-camogrom-l").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "L",
        "color": "Camogrom",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        productDB.collection("products").document("hk-urbantacticaltshirt-camogrom-xl").setData([
        "name": "Urban Tactical T-Shirt",
        "brand": "HELIKON-TEX",
        "size": "XL",
        "color": "Camogrom",
        "price": "2500",
        "id": "0",
        "quantity": 1
        ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        
        
        
        
        
        
        
    }

    
    
    
    
    
    
    
    // Populating the salesArray with DB documents.
    func firestoreToArray() {
        let salesTrackDB = Firestore.firestore()
        let salesRef = salesTrackDB.collection("sales track")
        
        // MARK: TODO: Fix snapshot listener
        // MARK: It's adding duplicate.
        // Solution: Use snapshot diff. Just append the diff to the array. 
        
        salesRef.addSnapshotListener { querySnapshot, err in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("New sale: \(diff.document.data())")
                    
                    //var addedData: [Product] = diff.document.data().values
                    let Name = diff.document.get("name") as! String
                    let Brand = diff.document.get("brand") as! String
                    let Size = diff.document.get("size") as! String
                    let Color = diff.document.get("color") as! String
                    let Price = diff.document.get("price") as! String
                    let Id = diff.document.get("id") as! String
                    let Quantity = diff.document.get("quantity") as! Int
                    
                    let tempSale = Product(name: Name, brand: Brand, size: Size, color: Color, price: Price, id: Id, quantity: Quantity)
                    print("?????")
                    print(self.salesArray)
                    self.salesArray.append(tempSale)
                    print(self.salesArray)
                    self.tableView.reloadData()
                }
                
                // MARK: Add 1 to existing sale.
                // This shit worked, HAHA
                // For when I +1 to existing sale, and update the view quantity.
                // I found the Product in the array, and manually added +1.
                if (diff.type == .modified) {
                    print("Modified sale: \(diff.document.data())")
                    print(diff.document.data().index(forKey: "id")!)
                    //print(diff.document.get("id"))
                    for i in self.salesArray {
                        if i.id == diff.document.get("id") as! String {
                            i.quantity += 1
                        }
                    }
                    print(self.salesArray)
                    self.tableView.reloadData()
                }
                }
            }

        }
        
        
        
//        salesRef.addSnapshotListener { (document, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//
//
//                // "get" document Fields.
//                for document in document!.documents {
//                    print(document.data())
//                    //accessing fields of document
//                    let Name = document.get("name") as! String
//                    let Brand = document.get("brand") as! String
//                    let Size = document.get("size") as! String
//                    let Color = document.get("color") as! String
//                    let Price = document.get("price") as! String
//                    let Id = document.get("id") as! String
//                    let Quantity = document.get("quantity") as! Int
//
//                    // Document Fields converted to my Product Class.
//                    let tempSale = Product(name: Name, brand: Brand, size: Size, color: Color, price: Price, id: Id, quantity: Quantity)
//                    //append Food to array
//
//
//                    self.salesArray.append(tempSale)
//                    print(self.salesArray)
//                    }
//
//
//                    self.tableView.reloadData()
//                }
//
//                //self.tableView.reloadData()
//        }
    }
//}
    

// Make the tableView!
extension SalesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell") as! productCell
        
        // Assign array data to each tableview cell.
        let sale = salesArray[indexPath.row]
        cell.setSale(sale: sale)
        return cell
    }
    
    
    // MARK: Cell Deletion
    // MARK: Delete the cell, also from DB.

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            //self.salesArray.remove(at: indexPath.row)
            
            // Get the cell ID (before removal from salesArray)
            // indexPath.row works because array is in same order.
            let ID = salesArray[indexPath.row].id
            print("The ID", ID)
            
            let salesTrackDB = Firestore.firestore()
            let salesRef = salesTrackDB.collection("sales track")
            
            // First delete from array.
            self.salesArray.remove(at: indexPath.row)
            
            // Second delete from DB
            salesRef.document(ID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print(self.salesArray)
                    print("Document successfully removed!")
                }
            }
            
            // delete from tableView
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }
    }
    
}

