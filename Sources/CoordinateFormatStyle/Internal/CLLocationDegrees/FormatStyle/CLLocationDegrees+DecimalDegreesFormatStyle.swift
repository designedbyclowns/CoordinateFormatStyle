import CoreLocation
import Foundation

extension CLLocationDegrees {
    
    /// A `FormatStyle` that converts a `CLLocationDegrees` into a string
    ///  representation using the `Decimal Degrees (DD) format.
    ///
    ///  - ``CoordinateFormat/decimalDegrees``
    struct DecimalDegreesFormatStyle : Foundation.FormatStyle, Sendable {
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
        
        func format(_ value: CLLocationDegrees) -> String {
            guard let coordinateComponent = try? CoordinateComponent(value, orientation: orientation) else { return "" }
            
            var degrees = coordinateComponent.value
            let hemisphere = coordinateComponent.hemisphere
                    
            if options.contains(.suffix) { degrees = abs(degrees) }
            
            var components: [String] = []
            
            let deg = degrees.formatted(
                .number.decimalSeparator(strategy: .automatic)
                .precision(
                    .fractionLength(1...5)
                )
            )
            
            components = ["\(deg)\(symbolStyle.degrees)"]
            
            if options.contains(.suffix) {
                components.append("\(hemisphere)")
            }
            
            let separator = options.contains(.compact) ? "" : " "
            
            return components.joined(separator: separator)
        }
    }
}
