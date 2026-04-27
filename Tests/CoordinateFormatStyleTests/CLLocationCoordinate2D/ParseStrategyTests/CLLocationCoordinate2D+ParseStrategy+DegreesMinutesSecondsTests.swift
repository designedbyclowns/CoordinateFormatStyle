import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_ParseStrategy_DegreesMinutesSecondsTests {
    
    let parseStrategy = CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds()
    
    @Test(arguments: [
        ("48° 6′ 59″ N, 122° 46′ 31″ W", CLLocationCoordinate2D.portTownsend),
        ("4° 40′ 40″ S, 55° 28′ 2″ E", CLLocationCoordinate2D.seychelles),
        ("62° 3′ 48″ N, 6° 52′ 25″ W", CLLocationCoordinate2D.faroeIslands),
        ("51° 22′ 25″ N, 179° 24′ 55″ E", CLLocationCoordinate2D.amchitkaIsland),
        ("0° 0′ 0″ N, 0° 0′ 0″ E", CLLocationCoordinate2D.nullIsland)
    ]) func decimalDegrees(arg: (String, CLLocationCoordinate2D)) throws {
        let match = try parseStrategy.parse(arg.0)
        #expect(match.isApproximatelyEqual(to: arg.1, absoluteTolerance: 0.001))
    }
    
    @Test(arguments: [
        "55° 58′ 45″ S, 67° 16′ 30″ W",
        "-55° 58′ 45″, -67° 16′ 30″",
        "55°58′45″S,67°16′30″W",
        "55° 58' 45\" S, 67° 16' 30\" W",
        "S 55° 58′ 45″, W 67° 16′ 30″",
        "55°58′45″S, 67°16′30″W",
        "55 58 45 S, 67 16 30 W",
    ]) func patternMatching(string: String) throws {
        let match = try parseStrategy.parse(string)
        #expect(match.isApproximatelyEqual(
            to: CLLocationCoordinate2D.capeHorn,
            absoluteTolerance: 0.0001
        ))
    }
    
    // Google uses a space instead of a comma as its delimiter for whatever reason
    @Test(arguments: [
//            "55°58′45″S 67°16′30″W",
        "55°58'45\"S 67°16'30\"W",
        "S55°58′45″ W67°16′30″",
        "55°58′45″S 67°16′30″W"
    ]) func googleFormat(string: String) throws {
        let match = try parseStrategy.parse(string)
        #expect(match.isApproximatelyEqual(
            to: CLLocationCoordinate2D.capeHorn,
            absoluteTolerance: 0.0001
        ))
    }
}
