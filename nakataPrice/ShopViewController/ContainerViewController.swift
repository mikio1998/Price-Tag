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

class ContainerViewController: UIViewController {
    
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
