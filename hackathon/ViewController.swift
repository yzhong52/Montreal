//
//  ViewController.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // Fixed Ion position
    var Ion_position_x0: Double = 100
    var Ion_position_y0: Double = 200
    
    // Initio electron position;
    var x0: Double = 50
    var y0: Double = 50
    
    // force F = k * q1 * q2 / r^2
    var q1: Double = -1
    var q2: Double = 1
    var k: Double = 1
    
    // electron mass
    var m: Double = 1
    
    // constant delta t
    var t: Double = 1/30
    
    static let V0: Double = 10
    
    static let Initial_alpha: Double = Double.pi / 4
    
    var V0x = V0 * cos(Initial_alpha)
    var V0y = V0 * sin(Initial_alpha)
    
    // start calculation ---------------------------------------------
    func startCalculation() {
        
        let r0_Vector_x = x0 - Ion_position_x0
        let r0_Vector_y = y0 - Ion_position_y0
        let r0 = sqrt(r0_Vector_x * r0_Vector_x + r0_Vector_y * r0_Vector_y)
        
        let cosalpha_r_x_0 = r0_Vector_x / r0
        let cosalpha_r_y_0 = r0_Vector_y / r0
        
        let F0 = k * q1 * q2 / r0 * r0
        let F0x = F0 * cosalpha_r_x_0
        let F0y = F0 * cosalpha_r_y_0
        
        let a0x = F0x / m
        let a0y = F0y / m
        
        // first moVement
        let x1 = x0 + V0x * t + 0.5 * a0x * t * t
        let y1 = y0 + V0y * t + 0.5 * a0y * t * t
        
        x0 = x1
        y0 = y1
        V0x = V0x + a0x * t
        V0y = V0y + a0y * t
        
        //        print("x0, y0 = \(x0) \(y0)")
        //        print("v0x, v0y = \(V0x) \(V0y)")
    }
    
    @IBOutlet var backgroundView: NSView!
    
    private var balls: [BallView] = []
    private weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
        startTimer()
        
        let aBall = BallView(view: view)
        aBall.x = CGFloat(Ion_position_x0)
        aBall.y = CGFloat(Ion_position_y0)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        for _ in 1...2 {
            let aBall = BallView(view: view,
                                 color: CGColor(red: 0, green: 0, blue: 1, alpha: 1),
                                 size: 5)
            balls.append(aBall)
        }
    }
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let zelf = self else {
                return
            }
            
            let aBall = zelf.balls.first!
            aBall.x = CGFloat(zelf.x0)
            aBall.y = CGFloat(zelf.y0)
            
            zelf.startCalculation()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
}

