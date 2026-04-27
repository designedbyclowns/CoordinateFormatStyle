import CoreLocation
import RegexBuilder

struct CoordinateFormatStyle: Sendable {
    static let comma: Character = "\u{002C}"
    static let space: Character = "\u{0020}"
    
    static func components(from value: String) throws -> [String] {
        // Prefer comma if there is one
        let separator = value.contains(Self.comma) ? Self.comma : Self.space
        
        let components = value
            .split(separator: separator)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        guard components.count == 2 else { throw ParsingError.noMatch }
        
        return components
    }
    
    static func resolveDirection(prefix: String?, suffix: String?, ignoreCase: Bool = false) throws -> CoordinateHemisphere? {
        
        var pfx = (prefix ?? "").isEmpty ? nil : prefix
        var sfx = (suffix ?? "").isEmpty ? nil : suffix
        
        if ignoreCase {
            pfx = pfx?.uppercased()
            sfx = sfx?.uppercased()
        }
        
        switch (pfx, sfx) {
        case let (.some(pfx), .some(sfx)):
            guard pfx == sfx else { throw ParsingError.conflict }
            return CoordinateHemisphere(rawValue: pfx)
        case let (.some(pfx), .none):
            return CoordinateHemisphere(rawValue: pfx)
        case let (.none, .some(sfx)):
            return CoordinateHemisphere(rawValue: sfx)
        case (.none, .none):
            return nil
        }
    }
    
    static func normalize(
        degrees: CLLocationDegrees,
        minutes: Double?,
        seconds: Double?,
        orientation: CoordinateOrientation,
        inHemisphere hemisphere: CoordinateHemisphere?
    ) throws -> CLLocationDegrees {
        var actualOrientation = orientation

        // The sign comes from the hemisphere when one is provided, otherwise from
        // the degrees value. Computing it up-front lets a hemisphere-driven sign
        // survive a degrees value of 0 (e.g. "0° 30′ 0″ S" → -0.5).
        let isNegative: Bool
        if let hemisphere {
            switch hemisphere {
            case .south, .west: isNegative = true
            case .north, .east: isNegative = degrees < 0
            }

            if orientation != .unspecified {
                // Expected orientation does not match parsed direction
                guard orientation == hemisphere.orientation else { throw ParsingError.invalidDirection }
            }

            actualOrientation = hemisphere.orientation
        } else {
            isNegative = degrees < 0
        }

        var magnitude = abs(degrees)
        if let minutes { magnitude += minutes / 60 }
        if let seconds { magnitude += seconds / 3600 }

        let signed = isNegative ? -magnitude : magnitude

        guard actualOrientation.range.contains(signed) else {
            throw ParsingError.invalidRangeDegrees
        }

        return signed
    }
    
    static var cardinalDirectionRegex: Optionally<Substring> {
        Optionally(.anyOf("NSEW"))
    }
}
