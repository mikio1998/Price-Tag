//
//  MenuViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 2/24/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit


class MenuViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    // Index of the currectly selected Menu item.
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
        
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
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        focusCell(indexPath: indexPath)
    }
    
    // Cell selection functionality
    func focusCell(indexPath: IndexPath) {
        // 以前選択されていたセルを非選択状態にする(collectionViewなので表示されていないセルは存在しない)
        // Set the previously selected cell to false.
        if let previousCell = collectionView?.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as? MenuViewCell {
            previousCell.focusCell(active: false)
        }
        // 新しく選択したセルを選択状態にする(collectionViewなので表示されていないセルは存在しない)
        // Set the newly selected cell to true.
        if let nextCell = collectionView?.cellForItem(at: indexPath as IndexPath) as? MenuViewCell {
            nextCell.focusCell(active: true)
        }
        // 現在選択されている位置を状態としてViewControllerに覚えさせておく
        // Store the indexPath of the currently selected cell.
        selectedIndex = indexPath.row
        
        // .CenteredHorizontallyでを指定して、CollectionViewのboundsの中央にindexPathのセルが来るようにする
        // Position the CollectionView with .CenteredHorisontally, and bring the selected cell to the center of the CollectionView bounds.
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    
    }
}
