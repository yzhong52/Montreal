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
        
        leftBall.wantsLayer = true
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    
    private let ballSize: CGFloat = 10
    override func viewWillAppear() {
        super.viewWillAppear()
        
        leftBall.wantsLayer = true
        leftBall.layer?.backgroundColor = CGColor.black
        
        
        let constraint = leftBall.topAnchor.constraint(equalTo: view.topAnchor)
        constraint.constant = 30
        constraint.isActive = true
        
        let leftConstraint = leftBall.leftAnchor.constraint(equalTo: view.leftAnchor)
        leftConstraint.constant = 30
        leftConstraint.isActive = true
        
        leftBall.widthAnchor.constraint(equalToConstant: ballSize).isActive = true
        leftBall.heightAnchor.constraint(equalToConstant: ballSize).isActive = true
        
        [leftBall].forEach { (aView) in
            if let aView = aView {
                aView.layer?.cornerRadius = ballSize / 2
                aView.layer?.backgroundColor = CGColor.black
            }
        }
    }
    
    
}

