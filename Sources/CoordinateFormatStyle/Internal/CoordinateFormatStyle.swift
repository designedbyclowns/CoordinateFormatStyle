import CoreLocation
@preconcurrency import RegexBuilder

struct CoordinateFormatStyle {
    static let comma: Character = "\u{002C}"
    static let space: Character = "\u{0020}"
    
    static func components(from value: String) throws(ParsingError) -> [String] {
        // Prefer comma if there is one
        let separator = value.contains(Self.comma) ? Self.comma : Self.space
        
        let components = value
            .split(separator: separator)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        guard components.count == 2 else { throw ParsingError.noMatch }
        
        return components
    }
    
    static func resolveDirection(prefix: String?, suffix: String?, ignoreCase: Bool = false) throws(ParsingError) -> CoordinateHemisphere? {
        
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
    
    static let cardinalDirectionRegex = Optionally(.anyOf("NSEW"))
}
