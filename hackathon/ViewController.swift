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
    private var rightBall = NSView(frame: NSRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    
    private let ballSize: CGFloat = 55
    override func viewWillAppear() {
        super.viewWillAppear()
        
        rightBall.wantsLayer = true
        
        rightBall.layer?.backgroundColor = CGColor.black
        
        
        
        view.addSubview(rightBall)
        rightBall.translatesAutoresizingMaskIntoConstraints = false
        
        [rightBall].forEach { (aView) in
            // if let aView = aView {
                let constraint = aView.topAnchor.constraint(equalTo: view.topAnchor)
                constraint.constant = 30
                constraint.isActive = true
                
                let leftConstraint = aView.leftAnchor.constraint(equalTo: view.leftAnchor)
                leftConstraint.constant = 30
                leftConstraint.isActive = true
                
                aView.widthAnchor.constraint(equalToConstant: ballSize).isActive = true
                aView.heightAnchor.constraint(equalToConstant: ballSize).isActive = true
                
                aView.layer?.cornerRadius = ballSize / 2
                aView.layer?.backgroundColor = CGColor.black
            // }
        }
    }
}

