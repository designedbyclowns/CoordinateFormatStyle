import Foundation
import CoreLocation
import GeoURI

extension CLLocationCoordinate2D {
    /// A `FormatStyle` that converts a `CLLocationCoordinate2D` into a string
    ///  representation using the ('geo' URI) format.
    ///
    ///  - ``CoordinateFormat/geoURI``
    public struct GeoUriFormatStyle : Foundation.FormatStyle, Sendable {
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

extension FormatStyle where Self == CLLocationCoordinate2D.GeoUriFormatStyle {
    public static var geoURI:  CLLocationCoordinate2D.GeoUriFormatStyle { .init() }
}
