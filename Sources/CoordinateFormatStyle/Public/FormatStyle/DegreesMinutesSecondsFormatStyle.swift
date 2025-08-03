import Foundation
import CoreLocation

/// A `FormatStyle` that converts a `CLLocationCoordinate2D` into a string
///  representation using the Degrees, Minutes, Seconds (DMS) format.
public typealias DegreesMinutesSecondsFormatStyle = CLLocationCoordinate2D.DegreesMinutesSecondsFormatStyle

extension CLLocationCoordinate2D {
    /// A `FormatStyle` that converts a `CLLocationCoordinate2D` into a string
    ///  representation using the Degrees, Minutes, Seconds (DMS) format.
    ///
    ///  - ``CoordinateFormat/degreesMinutesSeconds``
    public struct DegreesMinutesSecondsFormatStyle : Foundation.FormatStyle, Sendable {
        
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
            
            let style = CLLocationDegrees.DegreesMinutesSecondsFormatStyle()
                .symbolStyle(symbolStyle)
                .options(options)
            
            let lat = style.orientation(.latitude).format(value.latitude)
            let lon = style.orientation(.longitude).format(value.longitude)
            
            guard lat.isEmpty == false, lon.isEmpty == false else { return "" }
            
            return "\(lat), \(lon)"
        }
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.DegreesMinutesSecondsFormatStyle {
    public static var degreesMinutesSeconds:  CLLocationCoordinate2D.DegreesMinutesSecondsFormatStyle { .init() }
}
