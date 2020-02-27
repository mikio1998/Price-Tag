//
//  ContentViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 2/26/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//
// Content container

import Foundation
import UIKit


class ContentViewController: UIViewController {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = index {
            contentLabel.text = ViewModelManager.sharedInstance.data[index].content
            view.backgroundColor = ViewModelManager.sharedInstance.data[index].themeColor
        }
        
    }
    
}
