import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_DegreesDecimalMinutesFormatStyleTests {
    let formatStyle = CLLocationCoordinate2D.DegreesDecimalMinutesFormatStyle()
    
    @Test func defaultArguments() {
        #expect(CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0).formatted(formatStyle) == "90° 00.000', 180° 00.000'")
        #expect(CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(formatStyle) == "-90° 00.000', -180° 00.000'")
        #expect(CLLocationCoordinate2D(latitude: 90.01, longitude: 180.01).formatted(formatStyle) == "")
        #expect(CLLocationCoordinate2D(latitude: -90.01, longitude: -180.01).formatted(formatStyle) == "")
    }
    
    @Test func symbolStyle() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        let none = coordinate.formatted(formatStyle.symbolStyle(.none))
        #expect(none ==  "90 00.000, 180 00.000")
        
        let simple = coordinate.formatted(formatStyle.symbolStyle(.simple))
        #expect(simple ==  "90° 00.000', 180° 00.000'")
        
        let traditional = coordinate.formatted(formatStyle.symbolStyle(.traditional))
        #expect(traditional ==  "90° 00.000′, 180° 00.000′")
    }
    
    @Test func options() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        let none = coordinate.formatted(formatStyle.options([]))
        #expect(none ==  "90° 00.000', 180° 00.000'")
        
        let compact = coordinate.formatted(formatStyle.options(.compact))
        #expect(compact ==  "90°00.000', 180°00.000'")
        
        let suffix = coordinate.formatted(formatStyle.options(.suffix))
        #expect(suffix ==  "90° 00.000' N, 180° 00.000' E")
        
        let compactSuffix = coordinate.formatted(formatStyle.options([.compact, .suffix]))
        #expect(compactSuffix ==  "90°00.000'N, 180°00.000'E")
    }
}
