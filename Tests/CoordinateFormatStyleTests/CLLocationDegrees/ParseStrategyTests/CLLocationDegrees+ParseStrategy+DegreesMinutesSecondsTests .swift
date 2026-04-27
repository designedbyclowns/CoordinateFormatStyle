import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

struct CLLocationDegrees_DegreesMinutesSecondsParseStrategTests {
    let parseStrategy = CLLocationDegrees.ParseStrategy.DegreesMinutesSeconds()
    
    @Test(arguments: [
        "-55° 58′ 45\"",
        "-55° 58' 45\"",
        "-55 58 45",
        "-55°58′45\"",
        "55° 58′ 45″ S",
        "55° 58′ 45″ s",
        "55°58′45″S",
        "-55°58′45″",
        "-55° 58′ 45″ S",
        "S 55° 58′ 45″",
        "s 55° 58′ 45″",
        "S55°58′45″",
        "S -55° 58′ 45″",
        "S 55° 58′ 45″ S",
    ]) func match(string: String) {
        #expect(throws: Never.self) {
            let locationDegrees = try parseStrategy.parse(string)
            #expect(locationDegrees
                .isApproximatelyEqual(
                    to: CLLocationCoordinate2D.capeHorn.latitude,
                    absoluteTolerance: 0.00001
                )
            )
        }
    }
    
    @Test(arguments: [
        "55.97917° S",  // DD
        "55° 58.750′ S" // DDM
    ]) func noMatch(string: String) {
        #expect(throws: ParsingError.noMatch) {
            try parseStrategy.parse(string)
        }
    }
    
    @Test(arguments: [
        "180° 0' 1\" S",
        "180° 0' 1\"",
        "-180° 0' 1\""
    ]) func invalidRangeDegrees(string: String) {
        #expect(throws: ParsingError.invalidRangeDegrees) {
            try parseStrategy.parse(string)
        }
    }
    
    @Test func conflict() {
        #expect(throws: ParsingError.conflict) {
            try parseStrategy.parse("w 55° 58′ 45″ S")
        }
    }
}
