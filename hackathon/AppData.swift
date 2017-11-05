//
//  AppData.swift
//  hackathon
//
//  Created by Yuchen Zhong on 2017-11-04.
//  Copyright © 2017 Yuchen Zhong. All rights reserved.
//

import Foundation

private let V0: CGFloat = 10

private let Initial_alpha: CGFloat = CGFloat(Float.pi / 4)

struct AppData: Codable {
    var ions = [
        Ion(x: 200, y: 300, q: -1),
        Ion(x: 100, y: 250, q: -1)
    ]
    
    var electron = Electon(vx: V0 * cos(Initial_alpha),
                           vy: V0 * sin(Initial_alpha),
                           x: 300,
                           y: 300,
                           q: 1,
                           m: 1)
    
    static var settings = AppData()
    static var current = settings
}


extension Encodable {
    func jsonString() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self) {
            return String(data: data, encoding: String.Encoding.utf8) ?? ""
        } else {
            return ""
        }
    }
}
