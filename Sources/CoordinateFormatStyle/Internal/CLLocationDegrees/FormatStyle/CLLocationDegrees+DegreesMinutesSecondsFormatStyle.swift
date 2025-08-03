import CoreLocation
import Foundation

extension CLLocationDegrees {
    
    /// A `FormatStyle` that converts a `CLLocationDegrees` into a string
    ///  representation using the Degrees, Minutes, Seconds (DMS) format.
    ///
    ///  - ``CoordinateFormat/degreesMinutesSeconds``
    struct DegreesMinutesSecondsFormatStyle : Foundation.FormatStyle, Sendable {
        typealias FormatInput = CLLocationDegrees
        typealias FormatOutput = String
        
        var orientation: CoordinateOrientation
        var symbolStyle: SymbolStyle
        var options: DisplayOptions
        
        init(orientation: CoordinateOrientation = .unspecified, symbolStyle: SymbolStyle = .simple, options: DisplayOptions = []) {
            self.orientation = orientation
            self.symbolStyle = symbolStyle
            self.options = options
        }
        
        func orientation(_ orientation: CoordinateOrientation) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, options: options)
        }
        
        func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, options: options)
        }
        
        func options(_ options: DisplayOptions) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, options: options)
        }
        
        private var isCompact: Bool {
            // cant be compact if not using symbols
            options.contains(.compact) && symbolStyle != .none
        }
        
        func format(_ value: CLLocationDegrees) -> String {
            guard let coordinateComponent = try? CoordinateComponent(value, orientation: orientation) else { return "" }
            
            var degrees = coordinateComponent.value
            let hemisphere = coordinateComponent.hemisphere
                    
            if options.contains(.suffix) {
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
            
            if options.contains(.suffix) {
                components.append("\(hemisphere)")
            }
            
            return components.joined(separator: isCompact ? "" : " ")
        }
    }
}
