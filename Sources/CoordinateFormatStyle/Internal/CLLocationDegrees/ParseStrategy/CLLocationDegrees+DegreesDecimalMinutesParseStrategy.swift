import CoreLocation
import Foundation
import RegexBuilder


extension CLLocationDegrees {
    
    /// A `ParseStrategy` that parses a string formatted as Degrees and Decimal Minutes (DDM) into a CLLocationDegrees.
    ///
    /// - ``CoordinateFormat/degreesDecimalMinutes``
    struct DegreesDecimalMinutesParseStrategy: Foundation.ParseStrategy {
        
        init(
            orientation: CoordinateOrientation = .unspecified,
            options: ParsingOptions = [.caseInsensitive],
            precision: CLLocationDegrees.Precision? = nil,
        ) {
            self.orientation = .unspecified
            self.precision = precision
            self.options = options
        }
        
        // MARK: - ParseStrategy
        
        typealias ParseInput = String
        typealias ParseOutput = CLLocationDegrees
        
        func parse(_ value: String) throws(ParsingError) -> CLLocationDegrees {
            
            let prefixRef = Reference(Substring.self)
            let degreesRef = Reference(Double.self)
            let minutesRef = Reference(Double.self)
            let suffixRef = Reference(Substring.self)
                        
            let degreesRegex = Regex {
                Optionally {
                    "-"
                }
                Repeat(1...3) {
                    One(.digit)
                }
            }
            
            let minutesRegex = Regex {
                Repeat(1...2) {
                    One(.digit)
                }
                "."
                OneOrMore(.digit)
            }
            
            let regex = Regex {
                Anchor.startOfLine
                Capture(CoordinateFormatStyle.cardinalDirectionRegex, as: prefixRef)
                Optionally(.horizontalWhitespace)
                TryCapture(degreesRegex, as: degreesRef) {
                    guard let degrees = Double($0), (-180...180).contains(degrees) else {
                        throw ParsingError.invalidRangeDegrees
                    }
                    return degrees
                }
                OneOrMore(.horizontalWhitespace)
                TryCapture(minutesRegex, as: minutesRef) {
                    guard let minutes = Double($0), (0..<60).contains(minutes) else {
                        throw ParsingError.invalidRangeMinutes
                    }
                    return minutes
                }
                Optionally(.horizontalWhitespace)
                Capture(CoordinateFormatStyle.cardinalDirectionRegex, as: suffixRef)
                Anchor.endOfLine
            }
            .ignoresCase()
            .anchorsMatchLineEndings()
            
            guard let match = value.desymbolized().firstMatch(of: regex) else {
                throw ParsingError.noMatch
            }
                        
            let hemisphere: CoordinateHemisphere? = try CoordinateFormatStyle.resolveDirection(
                prefix: String(match[prefixRef]),
                suffix: String(match[suffixRef]),
                ignoreCase: options.contains(.caseInsensitive)
            )
            
            return try CLLocationDegrees(
                degrees: match[degreesRef],
                minutes: match[minutesRef],
                seconds: nil,
                precision: precision,
                orientation: orientation,
                inHemisphere: hemisphere
            )
        }
        
        // MARK: - Private
        
        private let orientation: CoordinateOrientation
        private let options: ParsingOptions
        private let precision: CLLocationDegrees.Precision?
    }
}

extension ParseStrategy where Self == CLLocationDegrees.DegreesDecimalMinutesParseStrategy {
    static var degreesDecimalMinutes:  CLLocationDegrees.DegreesDecimalMinutesParseStrategy { .init() }
}

extension CLLocationDegrees.DegreesDecimalMinutesFormatStyle: ParseableFormatStyle {
    var parseStrategy: CLLocationDegrees.DegreesDecimalMinutesParseStrategy {
        .init()
    }
}
