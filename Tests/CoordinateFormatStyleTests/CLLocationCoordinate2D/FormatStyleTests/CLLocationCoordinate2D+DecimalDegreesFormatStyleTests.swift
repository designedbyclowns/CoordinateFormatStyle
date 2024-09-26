import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_DecimalDegreesFormatStyleTests {
    let formatStyle = CLLocationCoordinate2D.DecimalDegreesFormatStyle()
    
    @Test func defaultArguments() {
        #expect(CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0).formatted(formatStyle) == "90.0°, 180.0°")
        #expect(CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(formatStyle) == "-90.0°, -180.0°")
        #expect(CLLocationCoordinate2D(latitude: 90.01, longitude: 180.01).formatted(formatStyle) == "")
        #expect(CLLocationCoordinate2D(latitude: -90.01, longitude: -180.01).formatted(formatStyle) == "")
    }
    
    @Test func symbolStyle() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        let none = coordinate.formatted(formatStyle.symbolStyle(.none))
        #expect(none ==  "90.0, 180.0")
        
        let simple = coordinate.formatted(formatStyle.symbolStyle(.simple))
        #expect(simple ==  "90.0°, 180.0°")
        
        let traditional = coordinate.formatted(formatStyle.symbolStyle(.traditional))
        #expect(traditional ==  "90.0°, 180.0°")
    }
    
    @Test func options() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        let none = coordinate.formatted(formatStyle.options([]))
        #expect(none ==  "90.0°, 180.0°")
        
        let compact = coordinate.formatted(formatStyle.options(.compact))
        #expect(compact ==  "90.0°, 180.0°")
        
        let suffixNE = coordinate.formatted(formatStyle.options(.suffix))
        #expect(suffixNE ==  "90.0° N, 180.0° E")
        
        let suffixSW = CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(formatStyle.options(.suffix))
        #expect(suffixSW ==  "90.0° S, 180.0° W")
        
        let compactSuffix = coordinate.formatted(formatStyle.options([.compact, .suffix]))
        #expect(compactSuffix ==  "90.0°N, 180.0°E")
    }
}
