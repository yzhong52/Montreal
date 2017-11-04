//
//  ViewController.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Cocoa

struct Ion {
    let x: CGFloat
    let y: CGFloat
    let q: CGFloat
}

struct Electon {
    let x: CGFloat
    let y: CGFloat
    let q: CGFloat
    let m: CGFloat
}

let k: CGFloat = 1

class ViewController: NSViewController {
    
    // Fixed Ion position
    var Ion_position_x0: Double = 100
    var Ion_position_y0: Double = 200
    
    let ions = [
        Ion(x: 100, y: 200, q: -2),
        Ion(x: 150, y: 300, q: -1)
    ]
    
    let eleton = Electon(x: 50, y: 50, q: 1, m: 1)
    
    // Initio electron position;
    var x0: CGFloat = 50
    var y0: CGFloat = 50
    
    // force F = k * q1 * q2 / r^2
    var q1: Double = -1
    var q2: Double = 1
    
    
    // electron mass
    var m: Double = 1
    
    // constant delta t
    var t: CGFloat = 1/30
    
    static let V0: CGFloat = 10
    
    static let Initial_alpha: CGFloat = CGFloat(Float.pi / 4)
    
    var V0x = V0 * cos(Initial_alpha)
    var V0y = V0 * sin(Initial_alpha)
    @IBOutlet var backgroundView: NSView!
    var electronView: BallView?
    private weak var timer: Timer?
    
    // start calculation ---------------------------------------------
    func startCalculation() {
        var totalAx: CGFloat = 0
        var totalAy: CGFloat = 0
        ions.forEach { (ion) in
            let r0_Vector_x = x0 - ion.x
            let r0_Vector_y = y0 - ion.y
            let r0 = sqrt(r0_Vector_x * r0_Vector_x + r0_Vector_y * r0_Vector_y)
            
            let cosalpha_r_x_0 = r0_Vector_x / r0
            let cosalpha_r_y_0 = r0_Vector_y / r0
            
            let F0 = k * eleton.q * ion.q / r0 * r0
            
            let F0x = F0 * cosalpha_r_x_0
            let F0y = F0 * cosalpha_r_y_0
            
            let a0x = F0x / eleton.m
            let a0y = F0y / eleton.m
            
            totalAx = totalAx + a0x
            totalAy = totalAy + a0y
        }
        
        // first moVement
        let x1 = x0 + V0x * t + 0.5 * totalAx * t * t
        let y1 = y0 + V0y * t + 0.5 * totalAy * t * t
        
        x0 = x1
        y0 = y1
        V0x = V0x + totalAx * t
        V0y = V0y + totalAy * t
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
        startTimer()
        
        ions.forEach { (ion) in
            let aBall = BallView(view: view)
            aBall.x = CGFloat(ion.x)
            aBall.y = CGFloat(ion.y)
        }
        
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        electronView = BallView(view: view,
                                color: CGColor(red: 0, green: 0, blue: 1, alpha: 1),
                                size: 5)
    }
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let zelf = self else {
                return
            }
            
            let aBall = zelf.electronView!
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

