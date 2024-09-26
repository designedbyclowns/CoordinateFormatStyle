import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationDegrees_DecimalDegreesParseStrategyTests {
    let parseStrategy = CLLocationDegrees.DecimalDegreesParseStrategy()
        
    @Test(arguments: [
        "55.97917° S",
        "55.97917°S",
        "-55.97917°",
        "-55.97917",
        "55.97917S",
        "-55.97917000000123",
        "S 55.97917°",
        "S55.97917°",
        "S     55.97917°",
        "s 55.97917°",
        "55.97917° s",
        "S 55.97917° s"
    ]) func match(string: String) {
        #expect(throws: Never.self) {
            let locationDegrees = try parseStrategy.parse(string)
            #expect(locationDegrees
                .isApproximatelyEqual(
                    to: CLLocationCoordinate2D.capeHorn.latitude,
                    absoluteTolerance: 0.000001
                )
            )
        }
    }
    
    @Test(arguments: [
        "55° 58.750′ S", // DDM
        "-55 58 45"      // DMS
    ]) func noMatch(string: String) {
        #expect(throws: ParsingError.noMatch) {
            try parseStrategy.parse(string)
        }
    }
    
    @Test(arguments: [
        "180.0001° S",
        "180.01°",
        "-180.01°"
    ]) func invalidRangeDegrees(string: String) {
        #expect(throws: ParsingError.noMatch) {
            try parseStrategy.parse(string)
        }
    }
    
    @Test func conflict() {
        #expect(throws: ParsingError.conflict) {
            try parseStrategy.parse("S 55.97917° N")
        }
    }
}
