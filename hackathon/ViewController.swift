//
//  ViewController.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var leftBall: NSView!
    @IBOutlet var rightBall: NSView!
    @IBOutlet var springResortView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [leftBall, rightBall].forEach { (aView) in
            aView?.layer?.cornerRadius = leftBall.frame.width / 2
            aView?.layer?.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        self.springResortView.rotate(byDegrees: 90)
        self.view.layer?.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

