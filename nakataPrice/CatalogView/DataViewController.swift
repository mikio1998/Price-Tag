//
//  BrandViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 3/3/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit

class DataViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var displayLabel: UILabel!
    
    // Sample Data
    var dataArray1 = ["Cell1","Cell2","Cell3","Cell4","Cell5","Cell6","Cell7","Cell8","Cell9","Cell1","Cell2","Cell3","Cell4","Cell5","Cell6","Cell7","Cell8","Cell9"]
        
    
    var displayText: String?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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

