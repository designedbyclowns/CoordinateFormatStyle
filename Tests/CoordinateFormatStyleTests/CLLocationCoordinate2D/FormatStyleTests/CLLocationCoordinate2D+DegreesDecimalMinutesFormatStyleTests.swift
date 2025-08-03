import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_DegreesDecimalMinutesFormatStyleTests {
    
    @Test func defaultArguments() {
        #expect(CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0).formatted(.degreesDecimalMinutes) == "90° 00.000', 180° 00.000'")
        #expect(CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(.degreesDecimalMinutes) == "-90° 00.000', -180° 00.000'")
        #expect(CLLocationCoordinate2D(latitude: 90.01, longitude: 180.01).formatted(.degreesDecimalMinutes) == "")
        #expect(CLLocationCoordinate2D(latitude: -90.01, longitude: -180.01).formatted(.degreesDecimalMinutes) == "")
    }
    
    @Test func symbolStyle() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: -180.0)
        
        let none = coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.none))
        #expect(none ==  "90 00.000, -180 00.000")
        
        let simple = coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.simple))
        #expect(simple ==  "90° 00.000', -180° 00.000'")
        
        let traditional = coordinate.formatted(.degreesDecimalMinutes.symbolStyle(.traditional))
        #expect(traditional ==  "90° 00.000′, -180° 00.000′")
    }
    
    @Test func options() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: -180.0)
        
        let none = coordinate.formatted(.degreesDecimalMinutes.options([]))
        #expect(none ==  "90° 00.000', -180° 00.000'")
        
        let compact = coordinate.formatted(.degreesDecimalMinutes.options(.compact))
        #expect(compact ==  "90°00.000', -180°00.000'")
        
        let suffix = coordinate.formatted(.degreesDecimalMinutes.options(.suffix))
        #expect(suffix ==  "90° 00.000' N, 180° 00.000' W")
        
        let compactSuffix = coordinate.formatted(.degreesDecimalMinutes.options([.compact, .suffix]))
        #expect(compactSuffix ==  "90°00.000'N, 180°00.000'W")
    }
}
