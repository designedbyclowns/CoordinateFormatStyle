import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationDegrees_FormatStyle_DegreesDecimalMinutes_Tests {
    let formatStyle = CLLocationDegrees.FormatStyle.DegreesDecimalMinutes()
    
    @Test func defaultArguments() {
        #expect(CLLocationDegrees(90.0).formatted(formatStyle) == "90° 00.000′ E")
        #expect(CLLocationDegrees(-90.0).formatted(formatStyle) == "90° 00.000′ W")
        #expect(CLLocationDegrees(90.01).formatted(formatStyle) == "90° 00.600′ E")
        #expect(CLLocationDegrees(-90.01).formatted(formatStyle) == "90° 00.600′ W")
        
        #expect(CLLocationDegrees(180.0).formatted(formatStyle) == "180° 00.000′ E")
        #expect(CLLocationDegrees(-180.0).formatted(formatStyle) == "180° 00.000′ W")
        #expect(CLLocationDegrees(180.01).formatted(formatStyle) == "")
        #expect(CLLocationDegrees(-180.01).formatted(formatStyle) == "")
    }
    
    @Test func symbolStyle() {
        let degrees =  CLLocationDegrees(90.0)
        
        let none = degrees.formatted(formatStyle.symbolStyle(.none))
        #expect(none ==  "90 00.000 E")
        
        let simple = degrees.formatted(formatStyle.symbolStyle(.simple))
        #expect(simple ==   "90° 00.000' E")
        
        let canonical = degrees.formatted(formatStyle.symbolStyle(.canonical))
        #expect(canonical ==  "90° 00.000′ E")
    }
    
    @Test func ordinalStyle() {
        var degrees = CLLocationDegrees(-180)
        
        var signed = degrees.formatted(formatStyle.ordinalStyle(.signed))
        #expect(signed == "-180° 00.000′")
        
        var suffix = degrees.formatted(formatStyle.ordinalStyle(.suffix))
        #expect(suffix == "180° 00.000′ W")
        
        degrees = CLLocationDegrees(180)
        
        signed = degrees.formatted(formatStyle.ordinalStyle(.signed))
        #expect(signed == "180° 00.000′")
        
        suffix = degrees.formatted(formatStyle.ordinalStyle(.suffix))
        #expect(suffix == "180° 00.000′ E")
    }
}
