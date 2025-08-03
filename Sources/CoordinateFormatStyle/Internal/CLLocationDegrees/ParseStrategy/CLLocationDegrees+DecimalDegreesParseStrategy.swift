import CoreLocation
import Foundation
import RegexBuilder


extension CLLocationDegrees {
    
    /// A `ParseStrategy` that parses a string formatted as Decimal Degrees (DD) into a CLLocationDegrees.
    ///
    /// - ``CoordinateFormat/decimalDegrees``
    struct DecimalDegreesParseStrategy : Foundation.ParseStrategy {
        init(
            orientation: CoordinateOrientation = .unspecified,
            options: ParsingOptions = [.caseInsensitive],
            precision: CLLocationDegrees.Precision? = nil,
        ) {
            self.orientation = .unspecified
            self.options = options
            self.precision = precision
        }
        
        // MARK: - ParseStrategy
        
        typealias ParseInput = String
        typealias ParseOutput = CLLocationDegrees
        
        
        func parse(_ value: String) throws(ParsingError) -> CLLocationDegrees {
            
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
                    guard let degrees = CLLocationDegrees($0), (-180...180).contains(degrees) else {
                        throw ParsingError.invalidRangeDegrees
                    }
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
            
            let hemisphere: CoordinateHemisphere? = try CoordinateFormatStyle.resolveDirection(
                prefix: String(match[prefixRef]),
                suffix: String(match[suffixRef]),
                ignoreCase: options.contains(.caseInsensitive)
            )
            
            return try CLLocationDegrees(
                degrees: match[degreesRef],
                minutes: nil,
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

extension ParseStrategy where Self == CLLocationDegrees.DecimalDegreesParseStrategy {
    static var decimalDegrees:  CLLocationDegrees.DecimalDegreesParseStrategy { .init() }
}

extension CLLocationDegrees.DecimalDegreesFormatStyle: ParseableFormatStyle {
    var parseStrategy: CLLocationDegrees.DecimalDegreesParseStrategy {
        .init()
    }
}
