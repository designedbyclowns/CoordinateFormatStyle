import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

import Foundation

struct CLLocationDegrees_ParseStrategy_DegreesDecimalMinutes_Tests {
    let parseStrategy = CLLocationDegrees.ParseStrategy.DegreesDecimalMinutes()
    
    @Test(arguments: [
        "55° 58.750′ S",
        "55° 58.750' S",
        "55°58.750′S",
        "-55°58.750′",
        "55 58.750′ S",
        "55 58.750 S",
        "-55 58.750",
        "-55° 58.750′",
        "55° 58.750′ W",
        "55° 58.750′ w",
        "55° 58.750′W",
        "W 55° 58.750′",
        "w 55° 58.750′",
        "W55° 58.750′"
    ]) func match(string: String) throws {
        let locationDegrees = try parseStrategy.parse(string)
        #expect(locationDegrees
            .isApproximatelyEqual(
                to: CLLocationCoordinate2D.capeHorn.latitude,
                absoluteTolerance: 0.00001
            )
        )
    }
    
    @Test func noMatch() {
        #expect(
            throws: ParsingError.noMatch,
            "Expected 'DD' format to not match 'DDM' format."
        ) {
            try parseStrategy.parse("-55.97917")
        }

        #expect(
            throws: ParsingError.noMatch,
            "Expected 'DMS' format to not match 'DDM' format."
        ) {
            try parseStrategy.parse("-55 58 45")
        }
    }
    
    @Test(arguments: [
        "180° 00.01′ E",
        "180° 00.001′ W",
        "-180° 00.01′",
        "90° 01.001′ N",
        "90° 01.001′ S"
    ]) func invalidRangeDegrees(string: String) {
        #expect(throws: ParsingError.invalidRangeDegrees) {
            try parseStrategy.parse(string)
        }
    }
    
    @Test(arguments: [
        "47° 60.1'",
        "47° 60.001′ S",
        "20° 60.001′ E",
        "120° 60.001′ W"
    ]) func invalidRangeMinutes(string: String) {
        #expect(throws: ParsingError.invalidRangeMinutes) {
            try parseStrategy.parse(string)
        }
    }
    
    @Test func conflict() {
        #expect(throws: ParsingError.conflict) {
            try parseStrategy.parse("N 55° 58.750′ S")
        }
    }

    @Test(arguments: [
        "90° 00.001′",
        "-90° 00.001′",
        "95° 00.000′ N"
    ]) func latitudeOutOfRange(string: String) {
        let latitudeStrategy = CLLocationDegrees.ParseStrategy.DegreesDecimalMinutes(orientation: .latitude)
        #expect(throws: ParsingError.invalidRangeDegrees) {
            try latitudeStrategy.parse(string)
        }
    }

    @Test func wrongAxisHemisphereThrowsInvalidDirection() {
        let latitudeStrategy = CLLocationDegrees.ParseStrategy.DegreesDecimalMinutes(orientation: .latitude)
        #expect(throws: ParsingError.invalidDirection) {
            try latitudeStrategy.parse("55° 00.000′ E")
        }
    }

    @Test(arguments: [
        ("0° 30.000′ S", -0.5),
        ("0° 30.000′ W", -0.5),
        ("0° 30.000′ N", 0.5),
        ("0° 30.000′ E", 0.5),
    ]) func zeroDegreeHemisphereSign(arg: (String, Double)) throws {
        let value = try parseStrategy.parse(arg.0)
        #expect(value.isApproximatelyEqual(to: arg.1, absoluteTolerance: 0.000001))
    }
}
