//
//  BrandViewController.swift
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
    var dataArray1 = ["Cell1","Cell2","Cell3","Cell4","Cell5","Cell6","Cell7","Cell8","Cell9","Cell1","Cell2","Cell3","Cell4","Cell5","Cell6","Cell7","Cell8","Cell9"]
        
    

    //  **Array index corresponds to product brand.**
    //  1 => Alpha
    //  2 => Valley
    //  3 => Houston
    //  4 => Helikon
    var index: Int?
    
    // Will use displayText as FirestoreToArray() input.
    // Since it's the same string.
    var displayText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        
        collectionView.delegate = self
        collectionView.dataSource = self

        firestoreToArray(brand: displayText!)
    }
    // MARK: FIRE TO ARRAY BRANDS
    // Input: Brand name
    // All products of brand
    func firestoreToArray(brand: String) {
        
        
        var productArray = [Dictionary<String, String>]()

        let firestoreDB = Firestore.firestore()
        
        // Filter by brand
        let productsDB = firestoreDB.collection("products").whereField("brand", isEqualTo: brand)
        
        //let extra = productsDB.whereField("size", isEqualTo: "M")
        
        
        productsDB.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("Got it")
                
                // For document in the query
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    
                    // Check if product is already in Array.
                    let searchVal = document.get("name") as! String
                    var notIn = true
                    // Add to productArray if it completes every loop
                    for product in productArray {
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
                        productArray.append(doc as! [String : String])
                    }

                }
            
                
            for i in productArray {
                print(i["name"])
            }

            }
        }
        
        
    }
    
}

extension DataViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // MARK: Config later
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection Cell", for: indexPath) as! SampleCell
        let data = dataArray1[indexPath.row]
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

