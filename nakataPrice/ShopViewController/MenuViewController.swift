//
//  MenuViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 2/24/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit


class MenuViewController: UICollectionViewController {
    
    
    // Index of the currectly selected Menu item.
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewModelManager.sharedInstance.data.count
    }
    
    // Number of sectons in CollectionView
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Configuring and loading menu cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuViewCell", for: indexPath) as! MenuViewCell
        
        let data = ViewModelManager.sharedInstance.data[indexPath.row]
        
        let active = (indexPath.row == selectedIndex)
        
        cell.configure(title: data.menuTitle, color: data.themeColor, active: active)
        
        return cell
    }
    
    
}
