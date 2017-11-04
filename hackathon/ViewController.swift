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
    
    private var balls: [BallView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        for _ in 1...10 {
            let aBall = BallView(view: view)
            aBall.x = CGFloat(arc4random() % UInt32(view.frame.height))
            aBall.y = CGFloat(arc4random() % UInt32(view.frame.width))
            balls.append(aBall)
        }
    }
}

