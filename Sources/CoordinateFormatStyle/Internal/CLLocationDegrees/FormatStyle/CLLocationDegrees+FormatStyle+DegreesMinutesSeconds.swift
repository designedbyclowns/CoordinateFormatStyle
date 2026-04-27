import CoreLocation
import Foundation

extension CLLocationDegrees.FormatStyle {
    /// A structure that converts between `CLLocationDegrees` values and
    /// their textual representations using the Degrees, Minutes, Seconds (DMS) format.
    internal struct DegreesMinutesSeconds : Foundation.FormatStyle, Sendable {
        
        internal typealias FormatInput = CLLocationDegrees
        internal typealias FormatOutput = String
        
        internal var orientation: CoordinateOrientation = .unspecified
        internal var symbolStyle: SymbolStyle
        internal var ordinalStyle: OrdinalDirectionStyle
        
        internal init(
            orientation: CoordinateOrientation = .unspecified,
            symbolStyle: SymbolStyle = .canonical,
            ordinalStyle: OrdinalDirectionStyle = .suffix
        ) {
            self.orientation = orientation
            self.symbolStyle = symbolStyle
            self.ordinalStyle = ordinalStyle
        }
        
        internal func orientation(_ orientation: CoordinateOrientation) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, ordinalStyle: ordinalStyle)
        }
        
        internal func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, ordinalStyle: ordinalStyle)
        }
        
        internal func ordinalStyle(_ ordinalStyle: OrdinalDirectionStyle) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, ordinalStyle: ordinalStyle)
        }
        
        internal func format(_ value: CLLocationDegrees) -> String {
            guard let coordinateComponent = try? CoordinateComponent(value, orientation: orientation) else { return "" }
            
            var degrees = coordinateComponent.value
            let hemisphere = coordinateComponent.hemisphere
                    
            if ordinalStyle == .suffix {
                degrees = abs(degrees)
            }
            
            let minutes = (abs(degrees) * 60.0).truncatingRemainder(dividingBy: 60.0)
            let seconds = (abs(degrees) * 3600.0).truncatingRemainder(dividingBy: 60.0)
            
            var components: [String] = []
            
            let deg = Int(degrees >= 0 ? floor(degrees) : ceil(degrees))
            let min = Int(floor(minutes))
            let sec = Int(seconds.rounded(.toNearestOrEven))
            
            components = [
                "\(deg)\(symbolStyle.degrees)",
                "\(min)\(symbolStyle.minutes)",
                "\(sec)\(symbolStyle.seconds)"
            ]
            
            if ordinalStyle == .suffix{
                components.append("\(hemisphere)")
            }
            
            return components.joined(separator:" ")
        }
    }
}
