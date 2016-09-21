//
//  HomeViewController.swift
//  AnalyzeThis
//
//  Created by Harris, Clifford on 9/21/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var containerCategory: UIView!
    @IBOutlet weak var containerMerchant: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchComponent(_ sender: AnyObject) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerCategory.alpha = 1
                self.containerMerchant.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerCategory.alpha = 0
                self.containerMerchant.alpha = 1
            })
        }
    }

}

