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
    
    private var ball: BallView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    
    private let ballSize: CGFloat = 55
    override func viewWillAppear() {
        super.viewWillAppear()
        
        ball = BallView(view: view)
    }
}

