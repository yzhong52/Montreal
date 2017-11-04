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
            balls.append(aBall)
        }
    }
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let zelf = self else {
                return
            }
            // do something here
            print("...")
            
            for aBall in zelf.balls {
                aBall.x = CGFloat(arc4random() % UInt32(zelf.view.frame.height))
                aBall.y = CGFloat(arc4random() % UInt32(zelf.view.frame.width))
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
}

