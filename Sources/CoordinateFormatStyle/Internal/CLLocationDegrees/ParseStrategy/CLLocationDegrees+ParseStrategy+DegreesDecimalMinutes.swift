import CoreLocation
import Foundation
import RegexBuilder


extension CLLocationDegrees.ParseStrategy {
    
    /// A parse strategy for creating `CLLocationDegrees` values
    /// from Degrees and Decimal Minutes (DDM) formatted strings.
    internal struct DegreesDecimalMinutes: Foundation.ParseStrategy, Sendable {
        
        internal init(
            orientation: CoordinateOrientation = .unspecified,
            options: ParsingOptions = [.caseInsensitive]
        ) {
            self.orientation = .unspecified
            self.options = options
        }
        
        // MARK: - ParseStrategy
        
        internal typealias ParseInput = String
        internal typealias ParseOutput = CLLocationDegrees
        
        internal func parse(_ value: String) throws -> CLLocationDegrees {
            
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
            
            return try CoordinateFormatStyle.normalize(
                degrees: match[degreesRef],
                minutes: match[minutesRef],
                seconds: nil,
                orientation: orientation,
                inHemisphere: hemisphere
            )
        }
        
        // MARK: - Private
        
        private let orientation: CoordinateOrientation
        private let options: ParsingOptions
    }
}
