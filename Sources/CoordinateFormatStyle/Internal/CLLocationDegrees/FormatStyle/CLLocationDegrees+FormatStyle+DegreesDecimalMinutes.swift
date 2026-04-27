import CoreLocation
import Foundation

extension CLLocationDegrees.FormatStyle {
    
    /// A structure that converts between `CLLocationDegrees` values and
    /// their textual representations using the Degrees and Decimal Minutes (DDM) format.
    internal struct DegreesDecimalMinutes : Foundation.FormatStyle, Sendable {
        internal typealias FormatInput = CLLocationDegrees
        internal typealias FormatOutput = String
        
        internal var orientation: CoordinateOrientation = .unspecified
        internal var symbolStyle: SymbolStyle
        internal var ordinalStyle: OrdinalDirectionStyle
        internal var compact: Bool
        
        internal init(
            orientation: CoordinateOrientation = .unspecified,
            symbolStyle: SymbolStyle = .canonical,
            ordinalStyle: OrdinalDirectionStyle  = .suffix,
            compact: Bool = false
        ) {
            self.orientation = orientation
            self.symbolStyle = symbolStyle
            self.ordinalStyle = ordinalStyle
            self.compact = compact
        }
        
        internal func orientation(_ orientation: CoordinateOrientation) -> Self {
            .init(
                orientation: orientation,
                symbolStyle: symbolStyle,
                ordinalStyle: ordinalStyle,
                compact: compact
            )
        }
        
        internal func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(
                orientation: orientation,
                symbolStyle: symbolStyle,
                ordinalStyle: ordinalStyle,
                compact: compact
            )
        }
        
        internal func ordinalStyle(_ ordinalStyle: OrdinalDirectionStyle) -> Self {
            .init(
                orientation: orientation,
                symbolStyle: symbolStyle,
                ordinalStyle: ordinalStyle,
                compact: compact
            )
        }
        
        internal func compact(_ compact: Bool) -> Self {
            .init(
                orientation: orientation,
                symbolStyle: symbolStyle,
                ordinalStyle: ordinalStyle,
                compact: compact
            )
        }
        
        internal func format(_ value: CLLocationDegrees) -> String {
            guard let coordinateComponent = try? CoordinateComponent(value, orientation: orientation) else { return "" }
            
            var degrees = coordinateComponent.value
            let hemisphere = coordinateComponent.hemisphere
                    
            if ordinalStyle == .suffix {
                degrees = abs(degrees)
            }
            
            let minutes = (abs(degrees) * 60.0).truncatingRemainder(dividingBy: 60.0)
            
            var components: [String] = []
            
            let deg = Int(degrees >= 0 ? floor(degrees) : ceil(degrees))
            
            let min = minutes.formatted(.number
                .decimalSeparator(strategy: .automatic)
                .precision(.integerAndFractionLength(integer: 2, fraction: 3))
            )
            
            components = [
                "\(deg)\(symbolStyle.degrees)",
                "\(min)\(symbolStyle.minutes)"
            ]
            
            if ordinalStyle == .suffix {
                components.append("\(hemisphere)")
            }
            
            let separator = compact ? "" : " "
                        
            return components.joined(separator:separator)
        }
    }
}
