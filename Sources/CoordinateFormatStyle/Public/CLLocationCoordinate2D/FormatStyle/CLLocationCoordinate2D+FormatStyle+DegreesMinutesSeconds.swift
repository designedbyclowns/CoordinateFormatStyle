public import Foundation
public import CoreLocation

extension CLLocationCoordinate2D.FormatStyle {
    
    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the Degrees, Minutes, Seconds (DMS) format.
    public struct DegreesMinutesSeconds : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
        
        /// Defines the characters used to annotate coordinate components.
        public var symbolStyle: SymbolStyle = .canonical
        
        /// Specifies how to indicate the ordinal direction of the latitude and longitude.
        public var ordinalStyle: OrdinalDirectionStyle
        
        public var compact: Bool
        
        public init(
            symbolStyle: SymbolStyle = .canonical,
            ordinalStyle: OrdinalDirectionStyle = .suffix,
            compact: Bool = false
        ) {
            self.symbolStyle = symbolStyle
            self.ordinalStyle = ordinalStyle
            self.compact = compact
        }
        
        /// Modifies the format style to use the specified ``SymbolStyle``.
        public func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }
        
        /// Modifies the format style to use the specified ``OrdinalDirectionStyle``.
        public func ordinalStyle(_ ordinalStyle: OrdinalDirectionStyle) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }
        
        public func compact(_ compact: Bool) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }
        
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value) else { return "" }
            
            let style = CLLocationDegrees.FormatStyle.DegreesMinutesSeconds()
                .symbolStyle(symbolStyle)
                .ordinalStyle(ordinalStyle)
                .compact(compact)
            
            let Φ = style.orientation(.latitude).format(value.latitude)
            let λ = style.orientation(.longitude).format(value.longitude)
            
            guard Φ.isEmpty == false, λ.isEmpty == false else { return "" }
            
            return "\(Φ), \(λ)"
        }
    }

    /// Sexagesimal, also known as base 60 is a numeral system with sixty as its base.
    ///
    /// It originated with the ancient Sumerians in the 3rd millennium BC, was passed down to
    /// the ancient Babylonians, and is still used—in a modified form—for measuring time,
    /// angles, and geographic coordinates.
    public typealias Sexagesimal = DegreesMinutesSeconds
        
}

extension CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds: ParseableFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds {
        .init()
    }
}
