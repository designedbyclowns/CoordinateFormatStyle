import Foundation
import CoreLocation
import UTMConversion

extension CLLocationCoordinate2D.FormatStyle {
    
    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the [Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) coordinate system.
    public struct UTM: Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
        
        public var ordinalStyle: OrdinalDirectionStyle
        
        public init(ordinalStyle: OrdinalDirectionStyle = .suffix) {
            self.ordinalStyle = ordinalStyle
        }

        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value), let utm = try? value.utmCoordinate() else {
                return ""
            }
            return UTMCoordinate.FormatStyle(ordinalStyle: ordinalStyle).format(utm)
        }
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.FormatStyle.UTM {
    public static var utm: Self { .init() }
}

