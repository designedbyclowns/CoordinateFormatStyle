import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_DecimalDegreesFormatStyleTests {
    
    @Test func defaultArguments() {
        #expect(CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0).formatted(.decimalDegrees) == "90.0°, 180.0°")
        #expect(CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(.decimalDegrees) == "-90.0°, -180.0°")
        #expect(CLLocationCoordinate2D(latitude: 90.01, longitude: 180.01).formatted(.decimalDegrees) == "")
        #expect(CLLocationCoordinate2D(latitude: -90.01, longitude: -180.01).formatted(.decimalDegrees) == "")
    }
    
    @Test func symbolStyle() {
        let coordinate = CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        let none = coordinate.formatted(.decimalDegrees.symbolStyle(.none))
        #expect(none ==  "90.0, 180.0")
        
        let simple = coordinate.formatted(.decimalDegrees.symbolStyle(.simple))
        #expect(simple ==  "90.0°, 180.0°")
        
        let traditional = coordinate.formatted(.decimalDegrees.symbolStyle(.traditional))
        #expect(traditional ==  "90.0°, 180.0°")
    }
    
    @Test func options() {
        let coordinate = CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        let none = coordinate.formatted(.decimalDegrees.options([]))
        #expect(none ==  "90.0°, 180.0°")
        
        let compact = coordinate.formatted(.decimalDegrees.options(.compact))
        #expect(compact ==  "90.0°, 180.0°")
        
        let suffixNE = coordinate.formatted(.decimalDegrees.options(.suffix))
        #expect(suffixNE ==  "90.0° N, 180.0° E")
        
        let suffixSW = CLLocationCoordinate2D(latitude: -90.0, longitude: -180.0).formatted(.decimalDegrees.options(.suffix))
        #expect(suffixSW ==  "90.0° S, 180.0° W")
        
        let compactSuffix = coordinate.formatted(.decimalDegrees.options([.compact, .suffix]))
        #expect(compactSuffix ==  "90.0°N, 180.0°E")
    }
    
    @Test func format() {
        let coordinate = CLLocationCoordinate2D(latitude: 90.0, longitude: 180.0)
        
        #expect("90.0°, 180.0°" == coordinate.formatted(.decimalDegrees))
        #expect("90° 00.000', 180° 00.000'" == coordinate.formatted(.degreesDecimalMinutes))
        #expect("90° 0' 0\", 180° 0' 0\"" == coordinate.formatted(.degreesMinutesSeconds))
        #expect("61 500000m E 9997965m N" == coordinate.formatted(.utm))
        #expect("geo:90,0;crs=wgs84" == coordinate.formatted(.geoURI))
    }
    
    @Test func utm() {
        let coordinate = CLLocationCoordinate2D(latitude: 48.11638, longitude: -122.77527)
        
        #expect("10U 516726m E 5329260m N" == coordinate.formatted(.utm))
        
        let xxx = coordinate.formatted(.utm.options(.compact))
        #expect("10U 516726m 5329260m" == xxx)
        
        #expect("10U 516726m 5329260m" == coordinate.formatted(.utm.options(.compact)))
        #expect("10U 516726m E 5329260m N" == coordinate.formatted(.utm.options(.suffix)))
        #expect("10U 516726mE 5329260mN" == coordinate.formatted(.utm.options([.compact, .suffix])))
    }
    
    @Test func xxx() {
        
        
        
        let strategy = UTMFormatStyle().parseStrategy.precision(.decimalPlaces5)     // UTMParseStrategy().precision(.decimalPlaces5)
        
        do {
            let coordinate = try CLLocationCoordinate2D("10U 516726m E 5329260m N", parseStrategy: strategy)
            
            #expect(coordinate == CLLocationCoordinate2D(latitude: 48.11638, longitude: -122.77527))
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

