//
//  AppData.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Foundation

class AppData: Codable {
    var ions = [
        Ion(x: 200, y: 300, q: -1),
        Ion(x: 100, y: 250, q: -1)
    ]
    
    var electron = Electon(vx: V0 * cos(Initial_alpha),
                           vy: V0 * sin(Initial_alpha),
                           x: 25,
                           y: 25,
                           q: 1,
                           m: 1)
    
    static let current = AppData.init()
}
