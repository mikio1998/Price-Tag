//
//  CatalogViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 3/3/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class CatalogViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    // Datasource collection
    // MARK: BRANDS
    // ** Array order matters**
    //      - Will search Firestore using array (also page) index
    //      - Array index corresponds to product brand.
    //  1 => Alpha
    //  2 => Valley
    //  3 => Houston
    //  4 => Helikon
    //let dataSource = ["Alpha Industries","Valley Apparel","HOUSTON","HELIKON-TEX"]
    let dataSource = ["Alpha Industries","HELIKON-TEX","HOUSTON","AVIREX","Valley Apparel"]
    // Page index collection
    var currentViewControllerIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        
        
    }
    

    
    
    
    
    // MARK: Initialization logic
    func configurePageViewController() {
        
        //  Creates instance of CustomPageViewController
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        // Add the pageVC as a child VC to CatalogVC
        addChild(pageViewController)
        // Tell the pageViewController we moved to parent VC (which is self)
        // We're in this container
        pageViewController.didMove(toParent: self)
        
        
        // MARK: Constraints to fitting content into view window
        // Auto resizing to false
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding the pageVC's View into the contentView
        contentView.addSubview(pageViewController.view)
        
        
        
        
        let views: [String: Any] = ["pageView": pageViewController.view]
        
        
        // VisualFormat explaination:
        // pageView put 0pts away flush against the edges from the superview (Horizontal H, Vertical V)
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        
    }
    
    // Instantiate new instance of a DataViewController, assign an index, and return it back.
    func detailViewControllerAt(index: Int) -> DataViewController? {
        
        // Have to identify which VC (probably using index)
        // Then, somehow load that data...
        
        // Prevention from overstepping array index
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        
        guard let dataViewController = storyboard?.instantiateViewController(identifier: String(describing: DataViewController.self)) as? DataViewController else {
            return nil
        }
        
        
        // MARK: DataViewController config
        dataViewController.index = index
        dataViewController.displayText = dataSource[index]
        
        
        //dataViewController.firestoreToArray(brand: dataSource[index])
        
        // should probably do load.. sommething
        
//        dataViewController.collectionView.dataSource = self as? UICollectionViewDataSource
//        dataViewController.collectionView.reloadData()
        
        //print(dataViewController.productArray, "this here")
        return dataViewController
    }

}

// Delegate and datasource methods
extension CatalogViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        

    
    
    // Before and after
    
    // BEFORE
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DataViewController
        
        // MARK: Index config
        
        // the Current index
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        currentViewControllerIndex = currentIndex
        
        // If current Index == 0, theres no before.
        if currentIndex == 0 {
            return nil
        }
        
        // Set index as one before
        currentIndex -= 1
        
        // Instantiates a DataViewController, with the previous index.
        return detailViewControllerAt(index: currentIndex)
    }
    
    
    // AFTER
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DataViewController
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        currentViewControllerIndex = currentIndex
        
        
        // There's no VC after.
        if currentIndex == dataSource.count {
            return nil
        }
        currentIndex += 1
        
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
        
    }
    
     
}

