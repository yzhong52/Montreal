//
//  ViewController.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var backgroundView: NSView!
    @IBOutlet var leftBall: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [leftBall].forEach { (aView) in
            if let aView = aView {
                aView.layer?.cornerRadius = aView.frame.width / 2
                aView.layer?.backgroundColor = CGColor.black
            }
        }
        
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
    }



}

