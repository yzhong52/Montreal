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
    private weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
        startTimer()
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
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            // do something here
            print("...")
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
}

