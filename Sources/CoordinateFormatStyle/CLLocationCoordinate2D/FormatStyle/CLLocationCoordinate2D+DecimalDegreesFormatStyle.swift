import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the Decimal Degrees (DD) format.
    ///
    ///  - ``CoordinateFormat/decimalDegrees``
    public struct DecimalDegreesFormatStyle : Foundation.FormatStyle, Sendable {
        
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
        
        public var symbolStyle: SymbolStyle
        public var options: DisplayOptions
        
        public init(symbolStyle: SymbolStyle = .simple, options: DisplayOptions = []) {
            self.symbolStyle = symbolStyle
            self.options = options
        }
        
        public func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(symbolStyle: symbolStyle, options: options)
        }
        
        public func options(_ options: DisplayOptions) -> Self {
            .init(symbolStyle: symbolStyle, options: options)
        }
        
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value) else { return "" }
            
            let style = CLLocationDegrees.DecimalDegreesFormatStyle()
                .symbolStyle(symbolStyle)
                .options(options)
            
            let lat = style.orientation(.latitude).format(value.latitude)
            let lon = style.orientation(.longitude).format(value.longitude)
            
            guard lat.isEmpty == false, lon.isEmpty == false else { return "" }
            
            return "\(lat), \(lon)"
        }
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.DecimalDegreesFormatStyle {
    public static var decimalDegrees:  CLLocationCoordinate2D.DecimalDegreesFormatStyle { .init() }
}
