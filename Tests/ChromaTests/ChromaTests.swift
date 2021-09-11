import XCTest
@testable import Chroma

final class ChromaTests: XCTestCase {
    
    func testSimpleScale() throws {
        
        let start = UIColor.systemRed
        let end = UIColor.systemPurple
        
        let scale = Chroma.scale(start, end)
        
        XCTAssertEqual(scale.count, 4)
        
        XCTAssertEqual(scale[0].getRGB(), [235, 64.75, 91.5, 1])
        XCTAssertEqual(scale[1].getRGB(), [215, 70.5, 135, 1])
        XCTAssertEqual(scale[2].getRGB(), [195, 76.25, 178.5, 1])
        XCTAssertEqual(scale[3].getRGB(), [175, 82, 222, 1])
        
    }
    
}
