import CoreLocation
import Foundation

extension CLLocationDegrees {
    
    /// A `FormatStyle` that converts a `CLLocationDegrees` into a string
    ///  representation using the `Decimal Degrees (DD) format.
    ///
    ///  - ``CoordinateFormat/decimalDegrees``
    public struct DecimalDegreesFormatStyle : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationDegrees
        public typealias FormatOutput = String
        
        public var orientation: CoordinateOrientation
        public var symbolStyle: SymbolStyle
        public var options: DisplayOptions
        
        public init(orientation: CoordinateOrientation = .unspecified, symbolStyle: SymbolStyle = .simple, options: DisplayOptions = []) {
            self.orientation = orientation
            self.symbolStyle = symbolStyle
            self.options = options
        }
        
        public func orientation(_ orientation: CoordinateOrientation) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, options: options)
        }
        
        public func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, options: options)
        }
        
        public func options(_ options: DisplayOptions) -> Self {
            .init(orientation: orientation, symbolStyle: symbolStyle, options: options)
        }
        
        public func format(_ value: CLLocationDegrees) -> String {
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

extension FormatStyle where Self == CLLocationDegrees.DecimalDegreesFormatStyle {
    public static var decimalDegrees:  CLLocationCoordinate2D.DecimalDegreesFormatStyle { .init() }
}
