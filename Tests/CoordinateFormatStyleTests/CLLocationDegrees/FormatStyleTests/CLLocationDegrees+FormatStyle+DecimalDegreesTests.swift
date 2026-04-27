import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle
import Foundation

struct CLLocationDegrees_FormatStyle_DecimalDegrees_Tests {
    let formatStyle = CLLocationDegrees.FormatStyle.DecimalDegrees()
    
    @Test func defaultArguments() {
        #expect(CLLocationDegrees(90.0).formatted(formatStyle) == "90.0° E")
        #expect(CLLocationDegrees(-90.0).formatted(formatStyle) == "90.0° W")
        #expect(CLLocationDegrees(90.01).formatted(formatStyle) == "90.01° E")
        #expect(CLLocationDegrees(-90.01).formatted(formatStyle) == "90.01° W")
        
        #expect(CLLocationDegrees(180.0).formatted(formatStyle) == "180.0° E")
        #expect(CLLocationDegrees(-180.0).formatted(formatStyle) == "180.0° W")
        #expect(CLLocationDegrees(180.01).formatted(formatStyle) == "")
        #expect(CLLocationDegrees(-180.01).formatted(formatStyle) == "")
    }
    
    @Test func symbolStyle() {
        let degrees = CLLocationDegrees(90.0)
        
        let none = degrees.formatted(formatStyle.symbolStyle(.none))
        #expect(none == "90.0 E")
        
        let simple = degrees.formatted(formatStyle.symbolStyle(.simple))
        #expect(simple == "90.0° E")
        
        let canonical = degrees.formatted(formatStyle.symbolStyle(.canonical))
        #expect(canonical == "90.0° E")
    }
    
    @Test func ordinalStyle() {
        var degrees =  CLLocationDegrees(180)
        
        var signed = degrees.formatted(formatStyle.ordinalStyle(.signed))
        #expect(signed == "180.0°")
        
        var suffix = degrees.formatted(formatStyle.ordinalStyle(.suffix))
        #expect(suffix == "180.0° E")
        
        degrees =  CLLocationDegrees(-180)
        
        signed = degrees.formatted(formatStyle.ordinalStyle(.signed))
        #expect(signed == "-180.0°")
        
        suffix = degrees.formatted(formatStyle.ordinalStyle(.suffix))
        #expect(suffix == "180.0° W")
        
        
    }
}
