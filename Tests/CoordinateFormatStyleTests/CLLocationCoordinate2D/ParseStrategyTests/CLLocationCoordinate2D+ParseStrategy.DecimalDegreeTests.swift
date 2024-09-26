import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_ParseStrategy_DecimalDegreesTests {
    
    let parseStrategy = CLLocationCoordinate2D.DecimalDegreesParseStrategy()
    
    @Test(arguments: [
        ("48.11638° N, 122.77527° W", CLLocationCoordinate2D.portTownsend),
        ("4.67785° S, 55.46718° E", CLLocationCoordinate2D.seychelles),
        ("62.06323° N, 6.87355° W", CLLocationCoordinate2D.faroeIslands),
        ("51.37363° N, 179.41535° E", CLLocationCoordinate2D.amchitkaIsland),
        ("0.0° N, 0.0° E", CLLocationCoordinate2D.nullIsland)
    ]) func decimalDegrees(arg: (String, CLLocationCoordinate2D)) {
        #expect(throws: Never.self) {
            let match = try parseStrategy.parse(arg.0)
            #expect(match.isApproximatelyEqual(to: arg.1, absoluteTolerance: 0.0001))
        }
    }
    
    @Test(arguments: [
        "-55.97917°, -67.275°",
        "55.97917°S,67.275°W",
        "55.97917 S, 67.275 W",
        "S 55.97917, W 67.275",
        "-55.97917, -67.275"
    ]) func patternMatching(string: String) {
        #expect(throws: Never.self) {
            let match = try parseStrategy.parse(string)
            #expect(match.isApproximatelyEqual(
                to: CLLocationCoordinate2D.capeHorn,
                absoluteTolerance: 0.0001
            ))
        }
    }
    
    // Google uses a space instead of a comma as its delimiter. because google.
    @Test(arguments: [
        "55.97917°S 67.275°W",
        "-55.97917° -67.275°",
        "55.97917S 67.275W",
        "S55.97917 W67.275"
    ]) func googleFormat(string: String) {
        #expect(throws: Never.self) {
            let match = try parseStrategy.parse(string)
            #expect(match.isApproximatelyEqual(
                to: CLLocationCoordinate2D.capeHorn,
                absoluteTolerance: 0.0001
            ))
        }
    }
}
