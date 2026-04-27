import CoreLocation
import Foundation
import RegexBuilder


extension CLLocationDegrees.ParseStrategy {
    
    /// A parse strategy for creating `CLLocationDegrees` values
    /// from Decimal Degrees (DD) formatted strings.
    internal struct DecimalDegrees: Foundation.ParseStrategy, Sendable {
        internal init(
            orientation: CoordinateOrientation = .unspecified,
            options: ParsingOptions = [.caseInsensitive]
        ) {
            self.orientation = orientation
            self.options = options
        }
        
        // MARK: - ParseStrategy
        
        internal typealias ParseInput = String
        internal typealias ParseOutput = CLLocationDegrees
        
        internal func parse(_ value: String) throws -> CLLocationDegrees {
            
            let prefixRef = Reference(Substring.self)
            let degreesRef = Reference(CLLocationDegrees.self)
            let suffixRef = Reference(Substring.self)
            
            let degreesRegex = Regex {
                Optionally {
                    "-"
                }
                Repeat(1...3) {
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
                    guard let degrees = CLLocationDegrees($0) else { throw ParsingError.noMatch }
                    return degrees
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

            guard (-180.0...180.0).contains(match[degreesRef]) else {
                throw ParsingError.invalidRangeDegrees
            }

            let hemisphere: CoordinateHemisphere? = try CoordinateFormatStyle.resolveDirection(
                prefix: String(match[prefixRef]),
                suffix: String(match[suffixRef]),
                ignoreCase: options.contains(.caseInsensitive)
            )
            
            return try CoordinateFormatStyle.normalize(
                degrees: match[degreesRef],
                minutes: nil,
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
