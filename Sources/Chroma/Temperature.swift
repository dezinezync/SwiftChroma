//
//  Temperature.swift
//  
//
//  Created by Nikhil Nigade on 23/12/21.
//

import Foundation

extension Chroma {
    static public func temperature(_ value: Int) -> SomeColor? {
        let funcString = "chroma.temperature(\(value))._rgb"
        guard let comp = run("\(funcString)")?.toArray() as? [Double] else {
            return nil
        }
        return SomeColor(red: comp[0]/255.0, green: comp[1]/255.0, blue: comp[2]/255.0, alpha: comp[3]/1)
    }
}
