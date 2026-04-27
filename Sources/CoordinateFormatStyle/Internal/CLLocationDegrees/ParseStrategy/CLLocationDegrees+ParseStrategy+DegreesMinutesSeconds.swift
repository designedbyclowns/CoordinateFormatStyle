import CoreLocation
import Foundation
import RegexBuilder

internal extension CLLocationDegrees.ParseStrategy {
    
    /// A parse strategy for creating `CLLocationDegrees` values
    /// from Degrees, Minutes, Seconds (DMS) formatted strings.
    struct DegreesMinutesSeconds : Foundation.ParseStrategy, Sendable {
        
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
            let secondsRef = Reference(Double.self)
            let suffixRef = Reference(Substring.self)
                        
            let degreesRegex = Regex {
                Optionally {
                    "-"
                }
                Repeat(1...3) {
                    One(.digit)
                }
            }
            
            let minutesRegex = Repeat(1...2) {
                  One(.digit)
            }
            
            let secondsRegex = Regex {
                Repeat(1...2) {
                    One(.digit)
                }
                Optionally {
                    "."
                }
                ZeroOrMore(.digit)
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
                One(.horizontalWhitespace)
                TryCapture(minutesRegex, as: minutesRef) {
                    guard let minutes = Double($0), (0.0..<60.0).contains(minutes) else {
                        throw ParsingError.invalidRangeMinutes
                    }
                    return minutes
                }
                One(.horizontalWhitespace)
                TryCapture(secondsRegex, as: secondsRef) {
                    guard let seconds = Double($0), (0.0..<60.0).contains(seconds) else {
                        throw ParsingError.invalidRangeMinutes
                    }
                    return seconds
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
                seconds: match[secondsRef],
                orientation: orientation,
                inHemisphere: hemisphere
            )
        }
        
        // MARK: - Private
        
        private let orientation: CoordinateOrientation
        private let options: ParsingOptions
    }
}
