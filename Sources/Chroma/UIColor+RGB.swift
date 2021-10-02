//
//  UIColor+RGB.swift
//  UIColor+RGB
//
//  Created by Nikhil Nigade on 10/09/21.
//

#if os(macOS)
import Cocoa
public typealias SomeColor = NSColor
#else
import UIKit
public  typealias SomeColor = UIColor
#endif

public extension SomeColor {
    
    /// Returns the R,G,B and A channels from the color.
    /// - Parameter color: An instance of NSColor or UIColor
    /// - Returns: [red, green, blue, alpha]
    func getRGB() -> [CGFloat] {
        
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        
        getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        
        return [fRed, fGreen, fBlue, fAlpha].map { $0 * 255 }
        
    }
    
}
