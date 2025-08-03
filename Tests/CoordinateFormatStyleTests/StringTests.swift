import Testing
import CoreLocation
import Numerics
@testable import CoordinateFormatStyle

struct StringTests {
    
    @Test func decimalDegrees() throws {
        let string = "48.11638° N, 122.77527° W"
        let coordinate = try string.coordinate(.decimalDegrees)
        #expect(coordinate.isApproximatelyEqual(to: .portTownsend, precision: .decimalPlaces8))
    }
    
    @Test func degreesDecimalMinutes() throws {
        let string = "48° 06.983′ N, 122° 46.516′ W"
        let coordinate = try string.coordinate(.degreesDecimalMinutes)
        #expect(coordinate.isApproximatelyEqual(to: .portTownsend, precision: .decimalPlaces5))
    }
    
    @Test func degreesMinutesSeconds() throws {
        let string = "48° 6′ 59″ N, 122° 46′ 31″ W"
        let coordinate = try string.coordinate(.degreesMinutesSeconds)
        #expect(coordinate.isApproximatelyEqual(to: .portTownsend, precision: .decimalPlaces5))
    }
    
    @Test func utm() throws {
        let string = "10U 516726m E 5329260m N"
        let coordinate = try string.coordinate(.utm)
        #expect(coordinate.isApproximatelyEqual(to: .portTownsend, precision: .decimalPlaces6))
    }
    
    @Test func geoURI() throws {
        let string = "geo:48.11638,-122.77527"
        let coordinate = try string.coordinate(.geoURI)
        #expect(coordinate.isApproximatelyEqual(to: .portTownsend, precision: .decimalPlaces8))
    }
}
