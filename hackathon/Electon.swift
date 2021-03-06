//
//  Electon.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Foundation

extension CGFloat {
    var string: String {
        return "\(self)"
    }
}
struct Electon: PositionType, Codable {
    var vx: CGFloat
    var vy: CGFloat
    var x: CGFloat
    var y: CGFloat
    let q: CGFloat
    let m: CGFloat
}
