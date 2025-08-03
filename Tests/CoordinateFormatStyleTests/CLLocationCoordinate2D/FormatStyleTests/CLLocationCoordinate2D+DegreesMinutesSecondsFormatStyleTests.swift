import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_DegreesMinutesSecondsFormatStyleTests {
    
    @Test func defaultArguments() {
        #expect(CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0).formatted(.degreesMinutesSeconds) == "90° 0' 0\", 180° 0' 0\"")
        #expect(CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(.degreesMinutesSeconds) == "-90° 0' 0\", -180° 0' 0\"")
        #expect(CLLocationCoordinate2D(latitude: 90.01, longitude: 180.01).formatted(.degreesMinutesSeconds) == "")
        #expect(CLLocationCoordinate2D(latitude: -90.01, longitude: -180.01).formatted(.degreesMinutesSeconds) == "")
    }
    
    @Test func symbolStyle() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: -180.0)
        
        let none = coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.none))
        #expect(none ==  "90 0 0, -180 0 0")
        
        let simple = coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.simple))
        #expect(simple ==  "90° 0' 0\", -180° 0' 0\"")
        
        let traditional = coordinate.formatted(.degreesMinutesSeconds.symbolStyle(.traditional))
        #expect(traditional ==  "90° 0′ 0″, -180° 0′ 0″")
    }
    
    @Test func options() {
        let coordinate =  CLLocationCoordinate2D(latitude: 90.0, longitude: -180.0)
        
        let none = coordinate.formatted(.degreesMinutesSeconds.options([]))
        #expect(none ==  "90° 0' 0\", -180° 0' 0\"")
        
        let compact = coordinate.formatted(.degreesMinutesSeconds.options(.compact))
        #expect(compact ==  "90°0'0\", -180°0'0\"")
        
        let suffix = coordinate.formatted(.degreesMinutesSeconds.options(.suffix))
        #expect(suffix ==  "90° 0' 0\" N, 180° 0' 0\" W")
        
        let compactSuffix = coordinate.formatted(.degreesMinutesSeconds.options([.compact, .suffix]))
        #expect(compactSuffix ==  "90°0'0\"N, 180°0'0\"W")
    }
}
