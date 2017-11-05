//
//  AngleCalculator.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-05.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Foundation

class AngleCalculator {
    // The constant we need to know
    static let h: CGFloat = 1500 // real constant
    static let width: CGFloat = 3000 // x
    static let length: CGFloat = 3000 // y
    
    static func calculate(x: CGFloat, y: CGFloat, x_w: CGFloat, x_l: CGFloat) -> (Int, Int) {
        
        let scale = width / x_w
        
        // distance from real time position to center
        let center_x = x_w / 2
        let center_y = x_l / 2
        
        let center_to_real_time_x = x - center_x
        let center_to_real_time_y = y - center_y
        
        let scale_center_to_real_time_x = (center_to_real_time_x) * scale
        let scale_center_to_real_time_y = (center_to_real_time_y) * scale
        
        let tan_x_alpha = scale_center_to_real_time_x / h
        
        let tan_y_alpha = scale_center_to_real_time_y / h
        
        let angle_x = Int(atan(tan_x_alpha) * 180 / CGFloat(Float.pi))
        let angle_y = Int(atan(tan_y_alpha) * 180 / CGFloat(Float.pi))
        
        return (angle_x + 90, angle_y + 90)
    }
}
