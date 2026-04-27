import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_FormatStyle_DegreesMinutesSecondsTests {
    
    let formatStyle = CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds()
        
    @Test func defaultArguments() {
        #expect(CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0).formatted(formatStyle) == "90° 0′ 0″ N, 180° 0′ 0″ E")
        #expect(CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(formatStyle) == "90° 0′ 0″ S, 180° 0′ 0″ W")
        #expect(CLLocationCoordinate2D(latitude: 90.01, longitude: 180.01).formatted(formatStyle) == "")
        #expect(CLLocationCoordinate2D(latitude: -90.01, longitude: -180.01).formatted(formatStyle) == "")
    }
    
    @Test func symbolStyle() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        let none = coordinate.formatted(formatStyle.symbolStyle(.none))
        #expect(none ==  "90 0 0 N, 180 0 0 E")
        
        let simple = coordinate.formatted(formatStyle.symbolStyle(.simple))
        #expect(simple ==  "90° 0' 0\" N, 180° 0' 0\" E")
        
        let canonical = coordinate.formatted(formatStyle.symbolStyle(.canonical))
        #expect(canonical ==  "90° 0′ 0″ N, 180° 0′ 0″ E")
    }
    
    @Test func ordinalStyle() {
        var coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        var signed = coordinate.formatted(formatStyle.ordinalStyle(.signed))
        #expect(signed ==  "90° 0′ 0″, 180° 0′ 0″")
        
        var suffix = coordinate.formatted(formatStyle.ordinalStyle(.suffix))
        #expect(suffix ==  "90° 0′ 0″ N, 180° 0′ 0″ E")
        
        coordinate =  CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0)
        
        signed = coordinate.formatted(formatStyle.ordinalStyle(.signed))
        #expect(signed ==  "-90° 0′ 0″, -180° 0′ 0″")
        
        suffix = coordinate.formatted(formatStyle.ordinalStyle(.suffix))
        #expect(suffix ==  "90° 0′ 0″ S, 180° 0′ 0″ W")
        
        
    }
}
