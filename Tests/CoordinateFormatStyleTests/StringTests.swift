import Testing
import CoreLocation
import Numerics
@testable import CoordinateFormatStyle

struct StringTests {
    @Test(arguments: [
        "48.11638° N, 122.77527° W",  // decimalDegrees
        "48° 06.983′ N, 122° 46.516′ W", // degreesDecimalMinutes
        "48° 6′ 59″ N, 122° 46′ 31″ W", // degreesMinutesSeconds
        "10U 516726m E 5329260m N", // UTM
        "geo:48.11638,-122.77527" // GeoURI
    ]) func coordinate(string: String) throws {
        let coordinate = try #require(string.coordinate())
        #expect(coordinate.isApproximatelyEqual(to: .portTownsend, absoluteTolerance: 0.0001))
    }
    
    @Test func coordinateNoMatch() throws {
        let coordinate = "xyz".coordinate()
        #expect(coordinate == nil)
    }
    
    @Test(arguments: [
        "48.11638° N",  // decimalDegrees
        "48° 06.983′ N", // degreesDecimalMinutes
        "48° 6′ 59″ N", // degreesMinutesSeconds
    ]) func degrees(string: String) throws {
        let degrees = try #require(string.degrees())
        
        #expect(degrees.isApproximatelyEqual(
            to: CLLocationCoordinate2D.portTownsend.latitude,
            absoluteTolerance: 0.0001)
        )
    }
    
    @Test func degreesNoMatch() throws {
        let degrees = "xyz".degrees()
        #expect(degrees == nil)
    }
}
