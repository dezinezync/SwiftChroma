import XCTest
@testable import Chroma

final class ChromaScaleTests: XCTestCase {
    
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
    
    func testHSLScale() throws {
        
        let start = UIColor.systemRed
        let end = UIColor.systemPurple
        
        let scale = Chroma.scale(start, end, mode: .hsl)
        
        XCTAssertEqual(scale.count, 4)
        
        XCTAssertEqual(scale[0].getRGB(), [247, 57, 112, 1])
        XCTAssertEqual(scale[1].getRGB(), [238, 65, 176, 1])
        XCTAssertEqual(scale[2].getRGB(), [230, 74, 228, 1])
        XCTAssertEqual(scale[3].getRGB(), [175, 82, 222, 1])
        
    }
    
    func testCorrectedLightness() throws {
        
        let start = UIColor.systemRed
        let end = UIColor.systemPurple
        
        let scale = Chroma.scale(start, end, correctLightness: true)
        
        XCTAssertEqual(scale.count, 4)
        
        XCTAssertEqual(scale[0].getRGB(), [246.875, 61.3359375, 65.671875, 1])
        XCTAssertEqual(scale[1].getRGB(), [237.65625, 63.986328125, 85.72265625, 1])
        XCTAssertEqual(scale[2].getRGB(), [226.640625, 67.1533203125, 109.681640625, 1])
        XCTAssertEqual(scale[3].getRGB(), [175, 82, 222, 1])
        
    }
    
    func testGrayscale() throws {
        
        let start = UIColor.white
        let end = UIColor.black
        
        let scale = Chroma.scale(start, end, steps: 5)
        
        XCTAssertEqual(scale.count, 5)
        
        XCTAssertEqual(scale[0].getRGB(), [204, 204, 204, 1])
        XCTAssertEqual(scale[1].getRGB(), [153, 153, 153, 1])
        XCTAssertEqual(scale[2].getRGB(), [102, 102, 102, 1])
        XCTAssertEqual(scale[3].getRGB(), [51, 51, 51, 1])
        XCTAssertEqual(scale[4].getRGB(), [0, 0, 0, 1])
        
    }
    
    func testPerformance() {
        
        measure {
            
            for _ in 0..<1000 {
                let start = randomColor
                let end = randomColor
                let _ = Chroma.scale(start, end)
            }
            
        }
        
    }
    
    private var randomColor: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
    
}
