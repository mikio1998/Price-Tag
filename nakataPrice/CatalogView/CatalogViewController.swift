//
//  CatalogViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 3/3/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import Foundation
import UIKit

class CatalogViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    // Datasource collection
    // MARK: BRANDS
    // ** Array order matters**
    //      - Will search Firestore using array (also page) index
    let dataSource = ["Alpha Industries","Valley Apparel","Houston","HELIKON-TEX"]
    // Page index collection
    var currentViewControllerIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        
    }
    
    // Initialization logic
    func configurePageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        // Add this as a child VC
        addChild(pageViewController)
        // Tell the pageViewController we moved to parent VC (which is self)
        // We're in this container
        pageViewController.didMove(toParent: self)
        
        //pageViewController.view.backgroundColor = UIColor.blue
        
        // MARK: Constraints to fitting content into view window
        // Auto resizing to false
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        // Adding the pageVC's view into the contentView
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
        
        // prevention from overstepping array index
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        
        guard let dataViewController = storyboard?.instantiateViewController(identifier: String(describing: DataViewController.self)) as? DataViewController else {
            return nil
        }
        
        // Mark: DataViewController config
        dataViewController.index = index
        dataViewController.displayText = dataSource[index]
        
        
        
        return dataViewController
    }

}

// Delegate and datasource methods
extension CatalogViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // Index to be displayed
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return currentViewControllerIndex
//    }
//
//    // Count of how many items in the collection, like number of rows.
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return dataSource.count
//    }
    
    
    // Before and after
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DataViewController
        
        // MARK: Index config
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DataViewController
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        currentViewControllerIndex = currentIndex
        
        if currentIndex == dataSource.count {
            return nil
        }
        currentIndex += 1
        
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
        
    }
    
     
}

