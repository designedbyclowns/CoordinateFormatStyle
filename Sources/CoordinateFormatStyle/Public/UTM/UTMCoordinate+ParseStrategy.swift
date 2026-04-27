public import Foundation
public import UTMConversion
import RegexBuilder

public extension UTMCoordinate {
    
    /// A parse strategy for creating `UTMCoordinate` values
    /// from strings formatted using the [Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) coordinate system.
    struct ParseStrategy: Foundation.ParseStrategy, Sendable {
        public typealias ParseInput = String
        public typealias ParseOutput = UTMCoordinate
        
        public func parse(_ value: String) throws -> UTMCoordinate {
            let zoneRef = Reference(UTMGridZone.self)
            let bandRef = Reference(UTMLatitudeBand.self)
            let eastingRef = Reference(Double.self)
            let northingRef = Reference(Double.self)

            let eastingOrNorthingRegex = Repeat(6...) {
                One(.digit)
            }

            let zoneRegex = ChoiceOf {
                Regex {
                  Optionally {
                    "0"
                  }
                  ("1"..."9")
                }
                Regex {
                  "1"
                  ("0"..."9")
                }
                Regex {
                  "2"
                  ("0"..."9")
                }
                Regex {
                  "3"
                  ("0"..."9")
                }
                Regex {
                  "4"
                  ("0"..."9")
                }
                Regex {
                  "5"
                  ("0"..."9")
                }
                "60"
            }

            let bandRegex = One(.anyOf("CDEFGHJKLMNPQRSTUVWX"))
            
            let utmRegex = Regex {
                Anchor.startOfLine
                TryCapture(zoneRegex, as: zoneRef) {
                    guard let zone = UTMGridZone($0) else {
                        throw ParsingError.invalidZone
                    }
                    return zone
                }
                TryCapture(bandRegex, as: bandRef) {
                    guard let band = UTMLatitudeBand(rawValue: String($0)) else {
                        throw ParsingError.invalidLatitudeBand
                    }
                    return band
                }
                
                OneOrMore(.horizontalWhitespace)
                TryCapture(eastingOrNorthingRegex, as: eastingRef) {
                    guard (6...7).contains(String($0).count), let value = Double($0) else {
                        throw ParsingError.noMatch
                    }
                    return value
                }
                "m"
                Optionally(.horizontalWhitespace)
                Optionally { "E" }
                OneOrMore(.horizontalWhitespace)
                TryCapture(eastingOrNorthingRegex, as: northingRef) {
                    guard (6...7).contains(String($0).count), let value = Double($0) else {
                        throw ParsingError.noMatch
                    }
                    return value
                }
                "m"
                Optionally(.horizontalWhitespace)
                Optionally { "N" }
                Anchor.endOfLine
            }
            .ignoresCase(true)
            .anchorsMatchLineEndings()
            
            guard let match = value.firstMatch(of: utmRegex) else {
                throw ParsingError.noMatch
            }
                                    
            return UTMCoordinate(
                northing: match[northingRef],
                easting: match[eastingRef],
                zone: match[zoneRef],
                hemisphere: match[bandRef].hemisphere
            )
        }
    }
}

extension UTMCoordinate.FormatStyle: ParseableFormatStyle {
    public var parseStrategy: UTMCoordinate.ParseStrategy {
        .init()
    }
}
