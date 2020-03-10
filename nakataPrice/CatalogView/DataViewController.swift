//
//  DataViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 3/3/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class DataViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var displayLabel: UILabel!
    
    // Sample Data
    var dataArray = ["Cell1","Cell2","Cell3","Cell4","Cell5","Cell6","Cell7","Cell8","Cell9","Cell10","Cell11","Cell12","Cell13","Cell14","Cell15","Cell16","Cell17","Cell18","Cell19"]
    
    // Contains all unique products per brand, from Firestore.
    var productArray = [Dictionary<String, String>]()
    
    
//    var alphaIndustriesArray = [Dictionary<String, String>]()
//    var valleyApparelArray = [Dictionary<String, String>]()
//    var houstonArray = [Dictionary<String, String>]()
//    var helikonTexArray = [Dictionary<String, String>]()

    

    //  **Array index corresponds to product brand.**
    //  1 => Alpha Industries
    //  2 => Valley Apparel
    //  3 => Houston
    //  4 => HELIKON-TEX
    var index: Int?
    
    // Will use displayText as FirestoreToArray() input.
    // Since it's the same string.
    var displayText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        
        firestoreToArray(brand: displayText!)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    // Maybe, should run this func for every brand.
    // As in, create a collection for each brand....
    // Then can fill in brand Arrays respectively.
    
    // MARK: FIRE TO ARRAY BRANDS
    // Input: Brand name
    // All products of brand
    func firestoreToArray(brand: String) {
        
        let firestoreDB = Firestore.firestore()
        
        // Filter by brand
        let productsDB = firestoreDB.collection("products").whereField("brand", isEqualTo: brand)
        
        productsDB.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // For document in the query... check if product is already in Array.
                for document in querySnapshot!.documents {

                    
                    // Check if product is already in Array.
                    let searchVal = document.get("name") as! String
                    var notIn = true
                    // Add to productArray if it completes every loop
                    for product in self.productArray {
                        // if it's already in there, Break loop.
                        if product["name"] == searchVal {
                            notIn = false
                            break
                        } else {
                            // else if it's not in there, continue looping.
                            continue
                        }
                    }
                    
                    // If true, append to brandArray
                    if notIn {
                        //var new = document
                        var doc = document.data() as [String:Any]
                        doc.removeValue(forKey: "quantity")
                                                
                        self.productArray.append(doc as! [String : String])
                    }
                }
            
            // just checking product collection
                for i in self.productArray {
                print(i["name"])
            }
                print(self.productArray)

                
                // Dammn, I just spent a week solving this problem... one line.
                self.collectionView.reloadData()
    
            }
        }
    }
    
    
    // MARK: del later
    func productToData1(array: Array<Any>) {
    }
    func productToData(array: [Dictionary<String, String>]) {
        // need name, color, price
    }
    
    
    
}


extension DataViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // MARK: Identify the brand of the current index
        // then create and use that array here.
        
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection Cell", for: indexPath) as! SampleCell
        
        let data = productArray[indexPath.row]["name"] ?? "Product"
        
        //let data = dataArray[indexPath.row]
        cell.setLabelandImage(label: data)
        return cell
    }
    
    
    
    
    
    
    // MARK: Cell size and Spacing!
    
    // Scaling cell sizing
    // Denominator: cells per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = -3 + (collectionView.bounds.width)/2.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    

}

