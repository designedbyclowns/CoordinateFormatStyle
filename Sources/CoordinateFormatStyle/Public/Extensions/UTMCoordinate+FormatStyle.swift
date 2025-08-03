import Foundation
import UTMConversion

/// A structure that converts between `UTMCoordinate` values and their textual representations.
public typealias UTMCoordinateFormatStyle = UTMCoordinate.FormatStyle

public extension UTMCoordinate {
    /// UTMCoordinate format style.
    struct FormatStyle : Foundation.FormatStyle {
        
        public init(options: DisplayOptions = [.suffix]) {
            self.options = options
        }
        
        public func options(_ options: DisplayOptions) -> Self {
            .init(options: options)
        }
        
        // MARK: - FormatStyle
        
        public typealias FormatInput = UTMCoordinate
        public typealias FormatOutput = String
        
        /// Creates a string representation of the `UTMCoordinate`.
        public func format(_ value: UTMCoordinate) -> String {
            let band = value.coordinate().latitudeBand?.rawValue ?? ""
            let easting = value.easting.formatted(Self.numberStyle).padding(toLength: 6, withPad: "0", startingAt: 0)
            let northing = value.northing.formatted(Self.numberStyle).padding(toLength: 7, withPad: "0", startingAt: 0)
            
            return "\(value.zone)\(band) \(easting)m\(eastingSuffix) \(northing)m\(northingSuffix)"
        }
        
        // MARK: - Private
        
        private let options: DisplayOptions
        
        private static let numberStyle = FloatingPointFormatStyle<Double>()
            .rounded()
            .precision(.integerLength(6...7))
            .precision(.fractionLength(0))
            .sign(strategy: .never)
            .grouping(.never)
        
        private var eastingSuffix: String {
            guard options.contains(.suffix) else { return "" }
            return options.contains(.compact) ?  "E" : " E"
            
        }
        private var northingSuffix: String {
            guard options.contains(.suffix) else { return "" }
            return options.contains(.compact) ?  "N" : " N"
        }
    }
}

extension FormatStyle where Self == UTMCoordinate.FormatStyle {
    static var compact: UTMCoordinate.FormatStyle { UTMCoordinate.FormatStyle(options: [.suffix, .compact]) }
    static var short:  UTMCoordinate.FormatStyle { UTMCoordinate.FormatStyle(options: [.compact]) }
}

extension UTMCoordinate {
    /// Converts `self` to its textual representation.
    /// - Returns: String
    public func formatted() -> String {
        Self.FormatStyle().format(self)
    }
    
    /// Converts `self` to another representation.
    /// - Parameter style: The format for formatting `self`
    /// - Returns: A representations of `self` using the given `style`. The type of the return is determined by the `FormatStyle`.`FormatOutput`.
    public func formatted<F: Foundation.FormatStyle>(_ style: F) -> F.FormatOutput where F.FormatInput == UTMCoordinate {
        style.format(self)
    }
}
