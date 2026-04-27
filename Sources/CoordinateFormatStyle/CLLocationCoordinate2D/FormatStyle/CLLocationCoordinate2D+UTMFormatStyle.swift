import Foundation
import CoreLocation
import UTMConversion

extension CLLocationCoordinate2D {
    
    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the [Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) coordinate system.
    ///
    ///  - ``CoordinateFormat/utm``
    public struct UTMFormatStyle : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
        
        public var options: DisplayOptions
        
        public init(options: DisplayOptions = [.suffix]) {
            self.options = options
        }

        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value), let utm = try? value.utmCoordinate() else {
                return ""
            }
            return UTMCoordinate.FormatStyle(options: options).format(utm)
        }
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.UTMFormatStyle {
    public static var utm:  CLLocationCoordinate2D.UTMFormatStyle { .init() }
}

