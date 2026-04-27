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

    @Test(arguments: [
        "90° 0′ 1″",
        "-90° 0′ 1″",
        "95° 0′ 0″ N"
    ]) func latitudeOutOfRange(string: String) {
        let latitudeStrategy = CLLocationDegrees.ParseStrategy.DegreesMinutesSeconds(orientation: .latitude)
        #expect(throws: ParsingError.invalidRangeDegrees) {
            try latitudeStrategy.parse(string)
        }
    }

    @Test func wrongAxisHemisphereThrowsInvalidDirection() {
        let latitudeStrategy = CLLocationDegrees.ParseStrategy.DegreesMinutesSeconds(orientation: .latitude)
        #expect(throws: ParsingError.invalidDirection) {
            try latitudeStrategy.parse("55° 0′ 0″ E")
        }
    }

    @Test(arguments: [
        "55° 0′ 60″",
        "55° 0′ 99″ N",
    ]) func invalidRangeSeconds(string: String) {
        #expect(throws: ParsingError.invalidRangeSeconds) {
            try parseStrategy.parse(string)
        }
    }

    @Test(arguments: [
        ("0° 30′ 0″ S", -0.5),
        ("0° 30′ 0″ W", -0.5),
        ("0° 0′ 30″ S", -0.5 / 60),
        ("0° 30′ 0″ N", 0.5),
        ("0° 30′ 0″ E", 0.5),
    ]) func zeroDegreeHemisphereSign(arg: (String, Double)) {
        #expect(throws: Never.self) {
            let value = try parseStrategy.parse(arg.0)
            #expect(value.isApproximatelyEqual(to: arg.1, absoluteTolerance: 0.000001))
        }
    }
}
