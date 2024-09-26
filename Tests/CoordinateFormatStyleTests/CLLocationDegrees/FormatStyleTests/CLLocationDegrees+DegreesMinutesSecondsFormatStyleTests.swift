import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationDegrees_DegreesMinutesSecondsFormatStyleTests {
    let formatStyle = CLLocationDegrees.DegreesMinutesSecondsFormatStyle()
    
    @Test func defaultArguments() {
        #expect(CLLocationDegrees(90.0).formatted(formatStyle) == "90° 0' 0\"")
        #expect(CLLocationDegrees(-90.0).formatted(formatStyle) == "-90° 0' 0\"")
        #expect(CLLocationDegrees(90.01).formatted(formatStyle) ==  "90° 0' 36\"")
        #expect(CLLocationDegrees(-90.01).formatted(formatStyle) == "-90° 0' 36\"")
        
        #expect(CLLocationDegrees(180.0).formatted(formatStyle) == "180° 0' 0\"")
        #expect(CLLocationDegrees(-180.0).formatted(formatStyle) == "-180° 0' 0\"")
        #expect(CLLocationDegrees(180.01).formatted(formatStyle) == "")
        #expect(CLLocationDegrees(-180.01).formatted(formatStyle) == "")
    }
    
    @Test func symbolStyle() {
        let degrees =  CLLocationDegrees(90.0)
        
        let none = degrees.formatted(formatStyle.symbolStyle(.none))
        #expect(none ==  "90 0 0")
        
        let simple = degrees.formatted(formatStyle.symbolStyle(.simple))
        #expect(simple ==  "90° 0' 0\"")
        
        let traditional = degrees.formatted(formatStyle.symbolStyle(.traditional))
        #expect(traditional ==  "90° 0′ 0″")
    }
    
    @Test func options() {
        let degrees =  CLLocationDegrees(180)
        
        let none = degrees.formatted(formatStyle.options([]))
        #expect(none == "180° 0' 0\"")
        
        let compact = degrees.formatted(formatStyle.options(.compact))
        #expect(compact == "180°0'0\"")
        
        let suffixE = degrees.formatted(formatStyle.options(.suffix))
        #expect(suffixE == "180° 0' 0\" E")
        
        let suffixW = CLLocationDegrees(-180).formatted(formatStyle.options(.suffix))
        #expect(suffixW == "180° 0' 0\" W")
        
        let compactSuffix = degrees.formatted(formatStyle.options([.compact, .suffix]))
        #expect(compactSuffix == "180°0'0\"E")
    }
}
