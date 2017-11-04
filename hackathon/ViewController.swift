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
    var vx: CGFloat
    var vy: CGFloat
    var x: CGFloat
    var y: CGFloat
    let q: CGFloat
    let m: CGFloat
}

let k: CGFloat = 1

class ViewController: NSViewController {
    
    // Fixed Ion position
    var Ion_position_x0: Double = 100
    var Ion_position_y0: Double = 200
    
    let ions = [
        Ion(x: 100, y: 100, q: 1),
//       Ion(x: 100, y: 50, q: -1),
//        Ion(x: 100, y: 0, q: 1),
//        Ion(x: 0, y: 100, q: 1),
//        Ion(x: 50, y: 0, q: -1),
//        Ion(x: 0, y: 50, q: -1),
//        Ion(x: 50, y: 100, q: -1),
//        Ion(x: 50, y: 50, q: 1),
//        Ion(x: 0, y: 0, q: 1),
    ]
    
    
    // constant delta t
    var t: CGFloat = 1/30
    
    static let V0: CGFloat = 10
    
    static let Initial_alpha: CGFloat = CGFloat(Float.pi / 4)
    
//    var V0x = V0 * cos(Initial_alpha)
//    var V0y = V0 * sin(Initial_alpha)
    var electron = Electon(vx: V0 * cos(Initial_alpha),
                         vy: V0 * sin(Initial_alpha),
                         x: 25,
                         y: 25,
                         q: 1,
                         m: 1)
    
    @IBOutlet var backgroundView: NSView!
    var electronView: BallView?
    var tailsView: [BallView] = []
    private weak var timer: Timer?
    
    // start calculation ---------------------------------------------
    func startCalculation() {
        var totalAx: CGFloat = 0
        var totalAy: CGFloat = 0
        ions.forEach { (ion) in
            let r0_Vector_x = electron.x - ion.x
            let r0_Vector_y = electron.y - ion.y
            let r0 = sqrt(r0_Vector_x * r0_Vector_x + r0_Vector_y * r0_Vector_y)
            
            let cosalpha_r_x_0 = r0_Vector_x / r0
            let cosalpha_r_y_0 = r0_Vector_y / r0
            
            let F0 = k * electron.q * ion.q / r0 * r0
            
            let F0x = F0 * cosalpha_r_x_0
            let F0y = F0 * cosalpha_r_y_0
            
            let a0x = F0x / electron.m
            let a0y = F0y / electron.m
            
            totalAx = totalAx + a0x
            totalAy = totalAy + a0y
        }
        
        // first moVement
        let x1 = electron.x + electron.vx * t + 0.5 * totalAx * t * t
        let y1 = electron.y + electron.vy * t + 0.5 * totalAy * t * t
        
        electron.x = x1
        electron.y = y1
        electron.vx = electron.vx + totalAx * t
        electron.vy = electron.vy + totalAy * t
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
        // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let zelf = self else {
                return
            }
            
            let aBall = zelf.electronView!
            aBall.x = CGFloat(zelf.electron.x)
            aBall.y = CGFloat(zelf.electron.y)
            
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

