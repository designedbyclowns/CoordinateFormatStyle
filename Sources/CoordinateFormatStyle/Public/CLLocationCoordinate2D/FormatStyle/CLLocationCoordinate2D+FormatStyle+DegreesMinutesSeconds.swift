import Foundation
import CoreLocation

extension CLLocationCoordinate2D.FormatStyle {
        
    public struct DegreesMinutesSeconds : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
        
        /// Defines the characters used to annotate coordinate components.
        public var symbolStyle: SymbolStyle = .canonical
        
        /// Specifies how to indicate the ordinal direction of the latitude and longitude.
        public var ordinalStyle: OrdinalDirectionStyle
        
        public init(
            symbolStyle: SymbolStyle = .canonical,
            ordinalStyle: OrdinalDirectionStyle = .suffix
        ) {
            self.symbolStyle = symbolStyle
            self.ordinalStyle = ordinalStyle
        }
        
        /// Modifies the format style to use the specified ``SymbolStyle``.
        public func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle)
        }
        
        /// Modifies the format style to use the specified ``OrdinalDirectionStyle``.
        public func ordinalStyle(_ ordinalStyle: OrdinalDirectionStyle) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle)
        }
        
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value) else { return "" }
            
            let style = CLLocationDegrees.FormatStyle.DegreesMinutesSeconds()
                .symbolStyle(symbolStyle)
                .ordinalStyle(ordinalStyle)
            
            let lat = style.orientation(.latitude).format(value.latitude)
            let lon = style.orientation(.longitude).format(value.longitude)
            
            guard lat.isEmpty == false, lon.isEmpty == false else { return "" }
            
            return "\(lat), \(lon)"
        }
    }

    /// Sexagesimal, also known as base 60 is a numeral system with sixty as its base.
    ///
    /// It originated with the ancient Sumerians in the 3rd millennium BC, was passed down to
    /// the ancient Babylonians, and is still used—in a modified form—for measuring time,
    /// angles, and geographic coordinates.
    public typealias Sexagesimal = DegreesMinutesSeconds
        
}
