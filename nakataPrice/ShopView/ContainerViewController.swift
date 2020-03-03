//
//  ContainerViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 2/26/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//
// View Controller holding menu and page containers.
// embed segue's for the menu and page VC's are identified as "embedMenuViewController", "embedPageViewController"


import Foundation
import UIKit

class ContainerViewController: UIViewController, UIPageViewControllerDataSource {

    
    // MARK: Delegate methods returning Previous and Next VC Pages
    
    // Delegate method that returns Previous VC page.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Check if its ContentViewController.
        guard let prevVc = viewController as? ContentViewController else {
            fatalError("not ContentViewController")
        }
        
        // ** $ refers to first parameter in the closure. **
        // If (previous page index - 1) is less than 0, return nil.
        // Since it'll be the first VC, nothing before it.
        guard let prevPageIndex = prevVc.index.flatMap({ $0 - 1 }), 0 <= prevPageIndex else {
            return nil
        }
        
        // Returns the previous VC.
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        vc.index = prevPageIndex
        return vc
        
    }
    
    
    // Delegate method that returns the Next VC page.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // Check if its ContentViewController.
        guard let nextVc = viewController as? ContentViewController else {
            fatalError("not ContentViewController")
        }
        
        // If next page index is greater than count of pages, return nil.
        // Since it'll be the last VC, nothing after it.
        guard let nextPageIndex = nextVc.index.flatMap({ $0 + 1 }), nextPageIndex < ViewModelManager.sharedInstance.data.count else {
            return nil
        }
        
        // Returns the next VC.
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        vc.index = nextPageIndex
        return vc
        
    }
    
    
    
    // MARK: Segueing to current menu and page VC's
    
    // Set variables for the menu and page VC's
    var menuViewController: MenuViewController?
    var pageViewController: UIPageViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Setting up the containers
        if let vc = segue.destination as? MenuViewController, segue.identifier == "embedMenuViewController" {
            menuViewController = vc
        } else if let vc = segue.destination as? UIPageViewController, segue.identifier == "embedPageViewController" {
            pageViewController = vc
        }
        
    }
    
}
