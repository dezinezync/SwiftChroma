//
//  Chroma.swift
//  Chroma
//
//  Created by Nikhil Nigade on 10/09/21.
//

import Foundation
import JavaScriptCore

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

internal struct JavaScriptBridge {
    internal static func chromajs() -> String? {
        
        let libPath = Bundle.module.path(forResource: "chroma", ofType: "js")
        
        guard let libPath = libPath else {
            return nil
        }

        do {
            return try String(contentsOfFile: libPath)
        } catch _ {
            return nil
        }
    }
}

public struct Chroma {

    /// The internal JS Context Chroma will use to interface with chroma.js
    internal static let chromaContext: JSContext? = {
        
        guard let chromajs = JavaScriptBridge.chromajs() else {
            return nil
        }
        
        let context = JSContext()
        
        context?.exceptionHandler = { context, exception in
            print("[Chroma] chroma.js error: \(String(describing: exception))")
        }
        
        let _ = context?.evaluateScript(chromajs)
        
        return context
        
    }()
    
    /// Chroma has different modes for scaling. See the documentation here:
    /// https://vis4.net/chromajs/#scale-mode
    enum ScaleMode: String {
        case rgb
        case lab
        case lch
        case hsl
        case lrgb
    }
    
    static func scale(_ start: SomeColor, _ end: SomeColor, steps: Int = 4, mode: Chroma.ScaleMode = .rgb, correctLightness: Bool = false) -> [SomeColor] {
        
        let startComps: [CGFloat] = start.getRGB()
        let endComps: [CGFloat] = end.getRGB()
        
        let startJSString = "\"rgb(\(startComps[0..<3].map({ "\(Int($0))" }).joined(separator: ",")))\""
        let endJSString = "\"rgb(\(endComps[0..<3].map({ "\(Int($0))" }).joined(separator: ",")))\""
        
        var funcString = "chroma.scale([\(startJSString), \(endJSString)])"
        
        if mode != .rgb {
            funcString += ".mode(\(mode.rawValue)"
        }
        
        if correctLightness {
            funcString += ".correctLightness()"
        }
        
        let _ = chromaContext?.evaluateScript("var output = \(funcString)")
        
        let compsString = "[...Array(\(steps))].map((_, i) => 1 + i * 1).map(n => output(n/\(steps))).map(c => c._rgb)"
        
        guard let instances = chromaContext?.evaluateScript(compsString).toArray() as? [[Double]] else {
            return []
        }
        
        let colors = instances.map { instance in
            return SomeColor(red: instance[0]/255, green: instance[1]/255, blue: instance[2]/255, alpha: instance[3]/255)
        }
        
        return colors
        
    }
    
}
