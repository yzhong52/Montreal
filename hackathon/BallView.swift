//
//  BallView.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Cocoa

let ballSize: CGFloat = 10
class BallView: NSView {
    var x: CGFloat = 0 {
        didSet {
            xPos?.constant = x
        }
    }
    var y: CGFloat = 0 {
        didSet {
            yPos?.constant = y
        }
    }
    
    private var xPos: NSLayoutConstraint? = nil
    private var yPos: NSLayoutConstraint? = nil
    
    init(view: NSView) {
        super.init(frame: NSRect.zero)
        
        view.addSubview(self)
        
        xPos = topAnchor.constraint(equalTo: view.topAnchor)
        xPos?.constant = 70
        xPos?.isActive = true
        
        wantsLayer = true
        
        layer?.backgroundColor = CGColor.black
        
        translatesAutoresizingMaskIntoConstraints = false
        
        yPos = leftAnchor.constraint(equalTo: view.leftAnchor)
        yPos?.constant = 70
        yPos?.isActive = true
        
        widthAnchor.constraint(equalToConstant: ballSize).isActive = true
        heightAnchor.constraint(equalToConstant: ballSize).isActive = true
        
        layer?.cornerRadius = ballSize / 2
        layer?.backgroundColor = CGColor.black
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
