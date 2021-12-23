//
//  Scale.swift
//  
//
//  Created by Nikhil Nigade on 23/12/21.
//

import Foundation

extension Chroma {
    /// Generate a scale from two colours interpolating between them for given points. Any valid chroma colours are supported. See ``valid(_:)`` for checking for valid colours.
    /// - Parameters:
    ///   - start: The start colour
    ///   - end: the end colour
    ///   - steps: number of total steps to generate for the gradient
    ///   - mode: the scaling mode to use
    ///   - correctLightness: true if lightness should be managed by the library to be even across generated colours
    /// - Returns: list of colours for the scale. If any errors are encountered, an empty list is returned.
    static public func scale(_ start: SomeColor, _ end: SomeColor, steps: Int = 4, mode: Chroma.ScaleMode = .rgb, correctLightness: Bool = false) -> [SomeColor] {
        
        let startComps: [CGFloat] = start.getRGB()
        let endComps: [CGFloat] = end.getRGB()
        
        let startJSString = "\"rgb(\(startComps[0..<3].map({ "\(Int($0))" }).joined(separator: ",")))\""
        let endJSString = "\"rgb(\(endComps[0..<3].map({ "\(Int($0))" }).joined(separator: ",")))\""
        
        var funcString = "chroma.scale([\(startJSString), \(endJSString)])"
        
        if mode != .rgb {
            funcString += ".mode(\"\(mode.rawValue)\")"
        }
        
        if correctLightness {
            funcString += ".correctLightness()"
        }
        
        let _ = run("var output = \(funcString)")
        
        let compsString = "[...Array(\(steps))].map((_, i) => (1 + i) * 1).map(n => output(n/\(steps))).map(c => c._rgb)"
        
        guard let instances = run(compsString)?.toArray() as? [[Double]] else {
            return []
        }
        
        let colors = instances.map { instance in
            return SomeColor(red: instance[0]/255, green: instance[1]/255, blue: instance[2]/255, alpha: instance[3]/1)
        }
        
        return colors
    }
}
