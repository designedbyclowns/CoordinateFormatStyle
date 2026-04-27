import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_FormatStyle_DegreesDecimalMinutes_Tests {
    let formatStyle = CLLocationCoordinate2D.FormatStyle.DegreesDecimalMinutes()
    
    @Test func defaultArguments() {
        #expect(CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0).formatted(formatStyle) == "90° 00.000′ N, 180° 00.000′ E")
        #expect(CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(formatStyle) == "90° 00.000′ S, 180° 00.000′ W")
        #expect(CLLocationCoordinate2D(latitude: 90.01, longitude: 180.01).formatted(formatStyle) == "")
        #expect(CLLocationCoordinate2D(latitude: -90.01, longitude: -180.01).formatted(formatStyle) == "")
    }
    
    @Test func symbolStyle() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        let none = coordinate.formatted(formatStyle.symbolStyle(.none))
        #expect(none == "90 00.000 N, 180 00.000 E")
        
        let simple = coordinate.formatted(formatStyle.symbolStyle(.simple))
        #expect(simple == "90° 00.000' N, 180° 00.000' E")
        
        let canonical = coordinate.formatted(formatStyle.symbolStyle(.canonical))
        #expect(canonical == "90° 00.000′ N, 180° 00.000′ E")
    }
    
    @Test func ordinalStyle() {
        var coordinate = CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0)
        
        var suffix = coordinate.formatted(formatStyle.ordinalStyle(.suffix))
        #expect(suffix == "90° 00.000′ S, 180° 00.000′ W")
        
        var signed = coordinate.formatted(formatStyle.ordinalStyle(.signed))
        #expect(signed == "-90° 00.000′, -180° 00.000′")
        
        coordinate = CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        suffix = coordinate.formatted(formatStyle.ordinalStyle(.suffix))
        #expect(suffix == "90° 00.000′ N, 180° 00.000′ E")
        
        signed = coordinate.formatted(formatStyle.ordinalStyle(.signed))
        #expect(signed == "90° 00.000′, 180° 00.000′")
    }
}
