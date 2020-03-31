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


protocol firestoreArrayProtocol {
    func firestoreToArray()
}

class SalesViewController: UIViewController, firestoreArrayProtocol {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Arrays
    // Products of floor ->
    var thirdFloorItems: [String] = ["ACU Jacket",
                                     "ACU Pants",
                                     "Covert Tactical Pants",
                                     "Greyman Tactical Jeans",
                                     "Outdoor Tactical Pants",
                                     "Urban Tactical Pants",
                                     "Urban Tactical Pants Canvas",
                                     "Urban Tactical Shorts",
                                     "Outdoor Tactical Pants Lite"
                                    ]
    
    // Firestore data ->
    struct GlobalVariable{
//        static var salesArray: [Product] = []
//        static var thirdFloorArray: [Product] = []
//        static var otherFloorArray: [Product] = []
        static var myString = "Hello"
    }

    
    var salesArray: [Product] = []
    
    var thirdFloorArray: [Product] = [] // thirdFloor -> tableView section 1
    var otherFloorArray: [Product] = [] // otherFloor -> tableView section 2
    
    
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
        
        //MARK: khaki
//        productDB.collection("products").document("hou-rainparka-navy-38").setData([
//        "name": "Rain Parka",
//        "brand": "HOUSTON",
//        "size": "38",
//        "color": "Navy",
//        "price": "28800",
//        "id": "0",
//        "quantity": 1
//        ])
//        { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
        
        
        
        
        
        
        
        
        
        
        
        
           
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

                    
                    // Append to belonging floor array.
                    
                    if self.thirdFloorItems.contains(tempSale.name) { // Check product's floor
                        self.thirdFloorArray.append(tempSale)
                    } else {
                        self.otherFloorArray.append(tempSale)
                    }
                    

                    //self.salesArray.append(tempSale)

                    self.tableView.reloadData()
                }
                
                // MARK: Add 1 to existing sale.
                // This shit worked, HAHA
                // For when I +1 to existing sale, and update the view quantity.
                // I found the Product in the array, and manually added +1.
                if (diff.type == .modified) {
                    print("Modified sale: \(diff.document.data())")
                    
                    let Name = diff.document.get("name") as! String
                    let Quantity = diff.document.get("quantity") as! Int
                    
                    //print(self.thirdFloorArray, "array 33")
                    if self.thirdFloorItems.contains(Name) { // Check product's floor
                        // find it on thirdFLoorArray
                        for element in self.thirdFloorArray {
                            if element.name == Name {
                                element.quantity = Quantity
                                break
                            }
                         }
                    } else {
                        for element in self.otherFloorArray {
                           if element.name == Name {
                               element.quantity = Quantity
                               break
                           }
                        }
                    }
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
        if section == 0 {                       // thirdFloorArray -> Section 0
            return self.thirdFloorArray.count
        } else {
            return self.otherFloorArray.count   // otherFloorArray -> Section 0
        }
        //return salesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell") as! productCell
        
        
        if indexPath.section == 0 {     // section: Third Floor
            let sale = thirdFloorArray[indexPath.row]
            cell.setSale(sale: sale)
        } else {                        // section: Other Floor
            let sale = otherFloorArray[indexPath.row]
            cell.setSale(sale: sale)
        }
        

        // Assign array data to each tableview cell.
        //let sale = salesArray[indexPath.row]
        //cell.setSale(sale: sale)
        
        return cell
    }
    
    
    // MARK: Sections
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if section == 0 {
            label.text = "３階"
        } else {
            label.text = "ほか"
        }

        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    
    // Section Header Sizing
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37.0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    // MARK: Cell Deletion
    // MARK: Delete the cell, also from DB.

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {

            
            
            if indexPath.section == 0 {     // deleting from thirdFloor
                // Get the cell ID (before removal from salesArray)
                // indexPath.row works because array is in same order.

                let ID = thirdFloorArray[indexPath.row].id
                print("The ID", ID)
                
                let salesTrackDB = Firestore.firestore()
                let salesRef = salesTrackDB.collection("sales track")
                
                // First delete from array.
                //let target = IndexPath(row: indexPath.row, section: 0)
                self.thirdFloorArray.remove(at: indexPath.row)
                
                // Second delete from DB
                salesRef.document(ID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print(self.thirdFloorArray)
                        print("Document successfully removed!")
                    }
                }
                
                // delete from tableView
                tableView.deleteRows(at: [indexPath], with: .bottom)
                tableView.reloadData()
                
            } else {                        // deleting from otherFloor
                
                let ID = otherFloorArray[indexPath.row].id
                print("The ID", ID)
                
                let salesTrackDB = Firestore.firestore()
                let salesRef = salesTrackDB.collection("sales track")
                
                // First delete from array.
                self.otherFloorArray.remove(at: indexPath.row)
                
                // Second delete from DB
                salesRef.document(ID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print(self.otherFloorArray)
                        print("Document successfully removed!")
                    }
                }
                
                // delete from tableView
                tableView.deleteRows(at: [indexPath], with: .bottom)
                tableView.reloadData()
            }
            
            
            
//            // Get the cell ID (before removal from salesArray)
//            // indexPath.row works because array is in same order.
//
//            let ID = salesArray[indexPath.row].id
//            print("The ID", ID)
//
//            let salesTrackDB = Firestore.firestore()
//            let salesRef = salesTrackDB.collection("sales track")
//
//            // First delete from array.
//            self.salesArray.remove(at: indexPath.row)
//
//            // Second delete from DB
//            salesRef.document(ID).delete() { err in
//                if let err = err {
//                    print("Error removing document: \(err)")
//                } else {
//                    print(self.salesArray)
//                    print("Document successfully removed!")
//                }
//            }
//
//            // delete from tableView
//            tableView.deleteRows(at: [indexPath], with: .bottom)
//            tableView.reloadData()
        }
    }
    
}

