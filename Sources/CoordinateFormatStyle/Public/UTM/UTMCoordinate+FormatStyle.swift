public import Foundation
public import UTMConversion

public extension UTMCoordinate {
    
    /// A structure that converts between `UTMCoordinate` values and
    /// their textual representations.
    struct FormatStyle: Foundation.FormatStyle, Sendable {
        
        public init(
            compact: Bool = false
        ) {
            self.compact = compact
        }
        
        public var compact: Bool
        
        // MARK: - FormatStyle
        
        public typealias FormatInput = UTMCoordinate
        public typealias FormatOutput = String
        
        public func format(_ value: UTMCoordinate) -> String {
            let band = value.coordinate().latitudeBand?.rawValue ?? ""
            let easting = value.easting.formatted(Self.numberStyle).padding(toLength: 6, withPad: "0", startingAt: 0)
            let northing = value.northing.formatted(Self.numberStyle).padding(toLength: 7, withPad: "0", startingAt: 0)
            
            return "\(value.zone)\(band) \(easting)m\(eastingSuffix) \(northing)m\(northingSuffix)"
        }
        
        public func compact(_ compact: Bool) -> Self {
            .init(compact: compact)
        }
        
        // MARK: - Private
        
        private static let numberStyle = FloatingPointFormatStyle<Double>()
            .rounded()
            .precision(.integerLength(6...7))
            .precision(.fractionLength(0))
            .sign(strategy: .never)
            .grouping(.never)
        
        private var eastingSuffix: String {
            return compact ?  "E" : " E"
        }
        
        private var northingSuffix: String {
            return compact ?  "N" : " N"
        }
    }
}

/*
extension FormatStyle where Self == UTMCoordinate.FormatStyle {
    static var compact: UTMCoordinate.FormatStyle { UTMCoordinate.FormatStyle(options: [.compact]) }
    static var short:  UTMCoordinate.FormatStyle { UTMCoordinate.FormatStyle(options: [.signed, .compact]) }
}
*/

public extension UTMCoordinate {
    /// Converts `self` to its textual representation.
    /// - Returns: String
    func formatted() -> String {
        Self.FormatStyle().format(self)
    }
    
    /// Converts `self` to another representation.
    /// - Parameter style: The format for formatting `self`
    /// - Returns: A representations of `self` using the given `style`. The type of the return is determined by the FormatStyle.FormatOutput
    func formatted<F: Foundation.FormatStyle>(_ style: F) -> F.FormatOutput where F.FormatInput == UTMCoordinate {
        style.format(self)
    }
}
