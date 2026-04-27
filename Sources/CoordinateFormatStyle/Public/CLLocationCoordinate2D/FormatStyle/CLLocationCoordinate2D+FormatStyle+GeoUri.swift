import Foundation
import CoreLocation
import GeoURI

extension CLLocationCoordinate2D.FormatStyle {
    
    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the ['geo' URI](https://geouri.org) scheme format.
    public struct GeoUri : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
        
        public var includeCRS: Bool
        
        public init(includeCRS: Bool = true) {
            self.includeCRS = includeCRS
        }
        
        // MARK: Customization Method Chaining

        public func includeCRS(_ includeCRS: Bool) -> Self {
            .init(includeCRS: includeCRS)
        }
        
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value), let geoURI = try? GeoURI(coordinate: value) else {
                return ""
            }
            return geoURI.formatted(includeCRS: includeCRS)
        }
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.FormatStyle.GeoUri {
    public static var geoURI: Self { .init() }
}
