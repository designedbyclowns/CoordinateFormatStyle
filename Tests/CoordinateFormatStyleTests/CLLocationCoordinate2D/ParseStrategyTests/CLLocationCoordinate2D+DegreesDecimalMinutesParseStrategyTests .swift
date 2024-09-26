import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationCoordinate2D_DegreesDecimalMinutesParseStrategyTests {
    
    let parseStrategy =  CLLocationCoordinate2D.DegreesDecimalMinutesParseStrategy()
    
    @Test(arguments: [
        ("48° 06.983′ N, 122° 46.516′ W", CLLocationCoordinate2D.portTownsend),
        ("4° 40.671′ S, 55° 28.031′ E", CLLocationCoordinate2D.seychelles),
        ("62° 03.794′ N, 6° 52.413′ W", CLLocationCoordinate2D.faroeIslands),
        ("51° 22.418′ N, 179° 24.921′ E", CLLocationCoordinate2D.amchitkaIsland),
        ("0° 00.000′ N, 0° 00.000′ E", CLLocationCoordinate2D.nullIsland)
        
    ]) func decimalDegrees(arg: (String, CLLocationCoordinate2D)) {
        #expect(throws: Never.self) {
            let match = try parseStrategy.parse(arg.0)
            #expect(match.isApproximatelyEqual(to: arg.1, absoluteTolerance: 0.0001))
        }
    }
    
    @Test(arguments: [
        "55° 58.750′ S, 67° 16.500′ W",
        "-55° 58.750′, -67° 16.500′",
        "55°58.750′S,67°16.500′W",
        "55° 58.750' S, 67° 16.500' W",
        "S 55° 58.750′ S, W 67° 16.500′"
    ]) func patternMatching(string: String) {
        #expect(throws: Never.self) {
            let match = try parseStrategy.parse(string)
            #expect(match.isApproximatelyEqual(
                to: CLLocationCoordinate2D.capeHorn,
                absoluteTolerance: 0.0001
            ))
        }
    }
    
    // Google uses a space instead of a comma as its delimiter for whatever reason
    @Test(arguments: [
        "55°58.750′S 67°16.500′W",
        "-55°58.750′ -67°16.500′",
        "55°58.750'S 67°16.500'W",
        "S55°58.750′S W67°16.500′"
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
