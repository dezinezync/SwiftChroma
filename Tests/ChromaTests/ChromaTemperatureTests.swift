//
//  ChromaTemperatureTests.swift
//  
//
//  Created by Nikhil Nigade on 23/12/21.
//

import XCTest
import Chroma

class ChromaTemperatureTests: XCTestCase {

    func testDaytimeTemperature() {
        let color = Chroma.temperature(5700)
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.getRGB(), [255.0, 238.95172996963817, 229.50375865822787, 255.0])
    }
    
    func testSunsetTemperature() {
        let color = Chroma.temperature(3500)
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.getRGB(), [255.0, 195.38578524373477, 138.27526351683466, 255.0])
    }
    
    func testNightTemperature() {
        let color = Chroma.temperature(8000)
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.getRGB(), [225.2605240191799, 232.30881312066407, 255.0, 255.0])
    }

}
