import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle
import Foundation

struct CLLocationCoordinate2D_UTMParseStrategyTests {
    let parseStrategy = CLLocationCoordinate2D.UTMParseStrategy()
    
    @Test(arguments: [
        ("10U 516726m E 5329260m N", CLLocationCoordinate2D.portTownsend),
        ("19F 607636m E 3794896m N", CLLocationCoordinate2D.capeHorn),
        ("40M 329980m E 9482760m N", CLLocationCoordinate2D.seychelles),
        ("29V 611132m E 6883046m N", CLLocationCoordinate2D.faroeIslands),
        ("60U 668108m E 5694144m N", CLLocationCoordinate2D.amchitkaIsland),
        ("31N 166021m E 000000m N", CLLocationCoordinate2D.nullIsland)
        
    ]) func decimalDegrees(arg: (String, CLLocationCoordinate2D)) {
        #expect(throws: Never.self) {
            let match = try parseStrategy.parse(arg.0)
            #expect(match.isApproximatelyEqual(to: arg.1, absoluteTolerance: 0.00001))
        }
    }
    
    @Test(arguments: [
        "10U 516726mE 5329260mN",
        "10U   516726m E   5329260m N",
        "10U 516726M e 5329260m n"
    ]) func utm(string: String) {
        #expect(throws: Never.self) {
            let match = try parseStrategy.parse(string)
            #expect(match.isApproximatelyEqual(
                to: CLLocationCoordinate2D.portTownsend,
                absoluteTolerance: 0.00001
            ))
        }
    }
    
    @Test func latitudeBandIsRequired() {
        // Latitude band is required because without it we cant determine the correct latitude.
        #expect(throws: ParsingError.noMatch) {
            try parseStrategy.parse("11 727771mE 5193170mN")
        }
    }
}
