//
//  ViewController.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Cocoa

let k: CGFloat = 1

let V0: CGFloat = 10

let Initial_alpha: CGFloat = CGFloat(Float.pi / 4)

let ions = [
    Ion(x: 200, y: 300, q: -1),
    Ion(x: 100, y: 250, q: -1),
    //        Ion(x: 100, y: 0, q: 1),
    //        Ion(x: 0, y: 100, q: 1),
    //        Ion(x: 50, y: 0, q: -1),
    //        Ion(x: 0, y: 50, q: -1),
    //        Ion(x: 50, y: 100, q: -1),
    //        Ion(x: 50, y: 50, q: 1),
    //        Ion(x: 0, y: 0, q: 1),
]

var electron = Electon(vx: V0 * cos(Initial_alpha),
                       vy: V0 * sin(Initial_alpha),
                       x: 25,
                       y: 25,
                       q: 1,
                       m: 1)



class ViewController: NSViewController {
    
    
    // constant delta t
    var t: CGFloat = 1/30
    
    
    @IBOutlet var backgroundView: NSView!
    var electronView: BallView?
    var tailsView: [BallView] = []
    private weak var timer: Timer?
    
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
        
        // First movment
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
            let ball = BallView(view: view)
            ball.x = ion.x
            ball.y = ion.y
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
            aBall.x = electron.x
            aBall.y = electron.y
            
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

