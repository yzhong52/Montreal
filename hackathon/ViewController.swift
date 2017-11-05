//
//  ViewController.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Cocoa

struct ViewControllerState {
    weak var vc: ViewController?
    var isPaused: Bool = false {
        didSet {
            if (isPaused) {
                vc?.startPauseButton.title = "Start"
                vc?.stopTimer()
            } else {
                vc?.startPauseButton.title = "Pause"
                vc?.startTimer()
            }
        }
    }
    
    static var current = ViewControllerState()
}

class ViewController: NSViewController {
    
    @IBOutlet var canvas: NSView!
    @IBOutlet var backgroundView: NSView!
    @IBOutlet var startPauseButton: NSButtonCell!
    
    private var electronView: BallView?
    
    private var ionViews: [BallView] = []
    
    private var tailsView: [BallView] = []
    
    private weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer?.backgroundColor = NSColor.white.cgColor
        
        ionViews = AppData.current.ions.map { (ion) in
            let ball = BallView(view: canvas)
            ball.setPos(pos: ion)
            return ball
        }
        ViewControllerState.current.vc = self
        ViewControllerState.current.isPaused = true
        
        textFieldVx.stringValue = AppData.current.electron.vx.string
        textFieldVy.stringValue = AppData.current.electron.vy.string
        textFieldX.stringValue = AppData.current.electron.x.string
        textFieldY.stringValue = AppData.current.electron.y.string
        textFieldQ.stringValue = AppData.current.electron.q.string
        textFieldM.stringValue = AppData.current.electron.m.string
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        electronView = BallView(view: canvas,
                                color: CGColor(red: 0, green: 0, blue: 1, alpha: 1),
                                size: 5)
        electronView?.setPos(pos: AppData.current.electron)
    }
    
    deinit {
        stopTimer()
    }
    
    func startTimer() {
        // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let zelf = self else { return }
            
            zelf.electronView?.setPos(pos: AppData.current.electron)
            zelf.startCalculation()
            
            let newTail = BallView(view: zelf.canvas, size: 1)
            newTail.setPos(pos: AppData.current.electron)
            newTail.layer?.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            zelf.tailsView.append(newTail)
            
            if zelf.tailsView.count > 50 {
                zelf.tailsView.first?.removeFromSuperview()
                zelf.tailsView.remove(at: 0)
            }
        }
    }
    
    func startCalculation() {
        // constant k
        let k: CGFloat = 1
        
        // constant delta t
        let t: CGFloat = 1/30
        
        var totalAx: CGFloat = 0
        var totalAy: CGFloat = 0
        
        let electron = AppData.current.electron
        let ions = AppData.current.ions
        
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
        
        AppData.current.electron.x = x1
        AppData.current.electron.y = y1
        AppData.current.electron.vx = electron.vx + totalAx * t
        AppData.current.electron.vy = electron.vy + totalAy * t
        
        // let str = "http://127.0.0.1:5000/?x=\(x1)&y=\(y1)"
        // let str = "http://10.10.204.152:5000/?x=\(Int(x1)%100)&y=\(Int(y1)%100)"
        let str = "http://10.10.204.152:5000/?x=2&y=2"
        let url = URL(string:str)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if let data = data,
                let reponseStr = String.init(data: data, encoding: String.Encoding.utf8) {
                print(reponseStr)
            }
        }
        task.resume()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @IBAction func startPauseButtonTapped(_ sender: NSButtonCell) {
        ViewControllerState.current.isPaused = !ViewControllerState.current.isPaused
    }
    
    @IBAction func resetButtonCTapped(_ sender: NSButtonCell) {
        AppData.current = AppData.settings
        electronView?.setPos(pos: AppData.current.electron)
        tailsView.forEach { $0.removeFromSuperview() }
        tailsView = []
        ViewControllerState.current.vc?.updateIonViews()
    }
    
    @IBOutlet var viewTappedGestureRecognizer: NSClickGestureRecognizer!
    @IBAction func viewTapped(_ sender: NSClickGestureRecognizer) {
        switch sender.state {
        case .ended:
            let pos = sender.location(in: view)
            let x = view.frame.height - pos.y
            let y = pos.x
            textFieldX.stringValue = "\(x)"
            rightTextFieldX.stringValue = "\(x)"
            textFieldY.stringValue = "\(y)"
            rightTextFieldY.stringValue = "\(y)"
            print("\(x) \(y)")
            let iconIndex = AppData.settings.ions.index(where: { (ion) -> Bool in
                return abs(ion.x - x) < 30 && abs(ion.y - y) < 30
            })
            if let iconIndex = iconIndex, iconIndex != NSNotFound {
                AppData.settings.ions.remove(at: iconIndex)
                AppData.current.ions.remove(at: iconIndex)
                updateIonViews()
            }
        default:
            print("do nothing for state \(sender.state.rawValue)")
        }
    }
    
    @IBAction func setElectronButtonTapped(_ sender: NSButton)
    {
        let currentElectron = AppData.settings.electron
        
        let newElecton = Electon(
            vx: textFieldVx.extractCGFloat() ?? currentElectron.vx,
            vy: textFieldVy.extractCGFloat() ?? currentElectron.vy,
            x: textFieldX.extractCGFloat() ?? currentElectron.x,
            y: textFieldY.extractCGFloat() ?? currentElectron.y,
            q: textFieldQ.extractCGFloat() ?? currentElectron.q,
            m: textFieldM.extractCGFloat() ?? currentElectron.m
        )
        
        AppData.settings.electron = newElecton
        AppData.current.electron = newElecton
        
        electronView?.setPos(pos: AppData.current.electron)
    }
    
    @IBAction func addIonButtonTapped(_ sender: NSButton)
    {
        let currentElectron = AppData.settings.electron
        let newIon = Ion(x: rightTextFieldX.extractCGFloat() ?? currentElectron.x,
                         y: rightTextFieldY.extractCGFloat() ?? currentElectron.y,
                         q: rightTextFieldQ.extractCGFloat() ?? currentElectron.q)
        AppData.settings.ions.append(newIon)
        AppData.current.ions.append(newIon)
        
        updateIonViews()
    }
    
    func updateIonViews() {
        ionViews.forEach { (ionView) in
            ionView.removeFromSuperview()
        }
        ionViews = AppData.current.ions.map { (ion) in
            let ball = BallView(view: canvas)
            ball.setPos(pos: ion)
            return ball
        }
    }
    
    @IBOutlet var textFieldVx: NSTextField!
    @IBOutlet var textFieldVy: NSTextField!
    @IBOutlet var textFieldX: NSTextField!
    @IBOutlet var textFieldY: NSTextField!
    @IBOutlet var textFieldQ: NSTextField!
    @IBOutlet var textFieldM: NSTextField!
    
    @IBOutlet var rightTextFieldX: NSTextField!
    @IBOutlet var rightTextFieldY: NSTextField!
    @IBOutlet var rightTextFieldQ: NSTextField!
    
}

extension NSTextField {
    func extractCGFloat() -> CGFloat? {
        return Float(stringValue).flatMap{ CGFloat($0) }
    }
}

