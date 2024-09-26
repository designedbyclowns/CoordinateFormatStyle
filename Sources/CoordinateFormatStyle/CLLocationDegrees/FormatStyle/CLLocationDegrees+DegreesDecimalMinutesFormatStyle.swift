import CoreLocation
import Foundation

extension CLLocationDegrees {
    
    /// A `FormatStyle` that converts a `CLLocationDegrees` into a string
    ///  representation using the Degrees and Decimal Minutes (DDM) format.
    ///
    ///  - ``CoordinateFormat/degreesDecimalMinutes``
    public struct DegreesDecimalMinutesFormatStyle : Foundation.FormatStyle, Sendable {
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
        
        private var isCompact: Bool {
            // cant be compact if not using symbols
            options.contains(.compact) && symbolStyle != .none
        }
        
        public func format(_ value: CLLocationDegrees) -> String {
            guard let coordinateComponent = try? CoordinateComponent(value, orientation: orientation) else { return "" }
            
            var degrees = coordinateComponent.value
            let hemisphere = coordinateComponent.hemisphere
                    
            if options.contains(.suffix) {
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
            
            if options.contains(.suffix) {
                components.append("\(hemisphere)")
            }
                        
            return components.joined(separator: isCompact ? "" : " ")
        }
    }
}

extension FormatStyle where Self == CLLocationDegrees.DegreesDecimalMinutesFormatStyle {
    public static var degreesDecimalMinutes:  CLLocationDegrees.DegreesDecimalMinutesFormatStyle { .init() }
}

