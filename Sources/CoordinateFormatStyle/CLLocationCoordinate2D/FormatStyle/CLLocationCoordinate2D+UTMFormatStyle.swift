import Foundation
import CoreLocation
import UTMConversion

extension CLLocationCoordinate2D {
    /// A `FormatStyle` that converts a `CLLocationCoordinate2D` into a string
    ///  representation using the Universal Transverse Mercator (UTM) format.
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

