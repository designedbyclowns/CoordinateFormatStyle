import CoreLocation
import Testing
import Numerics
@testable import CoordinateFormatStyle

import Foundation

struct CLLocationDegrees_DegreesDecimalMinutesParseStrategyTests {
    let parseStrategy = CLLocationDegrees.DegreesDecimalMinutesParseStrategy()
    
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
        #expect(throws: ParsingError.noMatch) {
            try parseStrategy.parse(string)
        }
    }
    
    @Test func conflict() {
        #expect(throws: ParsingError.conflict) {
            try parseStrategy.parse("N 55° 58.750′ S")
        }
    }
}
