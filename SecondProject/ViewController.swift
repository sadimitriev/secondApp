//
//  ViewController.swift
//  SecondProject
//
//  Created by Sergey Dimitriev on 17/06/2019.
//  Copyright © 2019 Sergey Dimitriev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ScreenHeight = UIScreen.main.bounds.size.height
        var ScreenWidth = UIScreen.main.bounds.size.width
        
        var test = ScreenHeight*0.333333
        
        TestButton.frame.size.height = test
        TestButton.frame.size.width = ScreenWidth
        TestButton.backgroundColor = UIColor.darkGray
        
        

        NSLayoutConstraint(item: TestButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: TestButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: test).isActive = true
        
    }


}

