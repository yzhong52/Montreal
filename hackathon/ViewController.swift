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
    @IBOutlet var rightBall: NSView!
    @IBOutlet var springResortView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [leftBall, rightBall].forEach { (aView) in
            if let aView = aView {
                aView.layer?.cornerRadius = aView.frame.width / 2
                aView.layer?.backgroundColor = CGColor.black
            }
        }
        
        springResortView.rotate(byDegrees: 90)
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
    }



}

