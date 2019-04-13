//
//  ViewController.swift
//  BackDrop Example
//
//  Created by Hootan Moradi on 4/13/19.
//  Copyright © 2019 Hootan Moradi. All rights reserved.
//

import UIKit
import SWBackDrop

class ViewController: UIViewController {

    var backDrop : SWBackDrop!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let droppedVC = storyboard?.instantiateViewController(withIdentifier: "droppedVC") as! DroppedViewController
        backDrop = SWBackDrop(parentViewController: self, backDropController: droppedVC, dropInset: 200, topInset: 100)
        backDrop.setupBackDroppedController()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backDrop.viewDidLayoutSubviews()
    }
    
    @IBAction func dropVC(_ sender: Any) {
        backDrop.isFocusedEmbeddedController = !backDrop.isFocusedEmbeddedController
    }
    
}

