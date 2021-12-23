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
    public enum ScaleMode: String {
        case rgb
        case lab
        case lch
        case hsl
        case lrgb
    }
    
    static internal func run(_ command: String) -> JSValue? {
        chromaContext?.evaluateScript(command)
    }
    
}
