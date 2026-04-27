import Testing
import CoreLocation
@testable import CoordinateFormatStyle

struct CoordinateHemisphereTests {

    @Test(arguments: [
        (CoordinateHemisphere.north, CoordinateOrientation.latitude),
        (CoordinateHemisphere.south, CoordinateOrientation.latitude),
        (CoordinateHemisphere.east, CoordinateOrientation.longitude),
        (CoordinateHemisphere.west, CoordinateOrientation.longitude),
    ]) func orientation(hemisphere: CoordinateHemisphere, expected: CoordinateOrientation) throws {
        #expect(hemisphere.orientation == expected)
    }
    
    @Test(arguments: [
        (CoordinateHemisphere.north, 0.0...90.0),
        (CoordinateHemisphere.south, -90.0...0.0),
        (CoordinateHemisphere.east, 0.0...180.0),
        (CoordinateHemisphere.west, -180.0...0.0),
    ]) func range(hemisphere: CoordinateHemisphere, expected: ClosedRange<CLLocationDegrees>) throws {
        #expect(hemisphere.range == expected)
    }
}
