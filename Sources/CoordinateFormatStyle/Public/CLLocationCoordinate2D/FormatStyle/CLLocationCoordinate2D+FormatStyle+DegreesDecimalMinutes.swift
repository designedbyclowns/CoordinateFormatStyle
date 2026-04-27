public import Foundation
public import CoreLocation

extension CLLocationCoordinate2D.FormatStyle {
    
    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the Degrees and Decimal Minutes (DDM) format.
    public struct DegreesDecimalMinutes: Foundation.FormatStyle, Sendable {
        
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
        
        public var symbolStyle: SymbolStyle = .canonical
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
        
        public func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }
        
        public func ordinalStyle(_ ordinalStyle: OrdinalDirectionStyle) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }
        
        public func compact(_ compact: Bool) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }
        
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value) else { return "" }
            
            let style = CLLocationDegrees.FormatStyle.DegreesDecimalMinutes()
                .symbolStyle(symbolStyle)
                .ordinalStyle(ordinalStyle)
                .compact(compact)
            
            let Φ = style.orientation(.latitude).format(value.latitude)
            let λ = style.orientation(.longitude).format(value.longitude)
            
            guard Φ.isEmpty == false, λ.isEmpty == false else { return "" }
            
            return "\(Φ), \(λ)"
        }
    }
}

extension CLLocationCoordinate2D.FormatStyle.DegreesDecimalMinutes: ParseableFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.ParseStrategy.DegreesDecimalMinutes {
        .init()
    }
}

