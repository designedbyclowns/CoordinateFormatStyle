import Foundation
import CoreLocation
import GeoURI

/// A `FormatStyle` that converts a `CLLocationCoordinate2D` into a string
///  representation using the ('geo' URI) format.
public typealias GeoURIFormatStyle = CLLocationCoordinate2D.GeoURIFormatStyle

extension CLLocationCoordinate2D {
    /// A `FormatStyle` that converts a `CLLocationCoordinate2D` into a string
    ///  representation using the ('geo' URI) format.
    ///
    ///  - ``CoordinateFormat/geoURI``
    public struct GeoURIFormatStyle : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String
                
        public init(includeCRS: Bool = true) {
            self.includeCRS = includeCRS
        }
        
        public func includeCRS(_ includeCRS: Bool) -> Self {
            .init(includeCRS: includeCRS)
        }
        
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value), let geoURI = try? GeoURI(coordinate: value) else {
                return ""
            }
            return geoURI.formatted(includeCRS: includeCRS)
        }
        
        // MARK: - Private
        
        private let includeCRS: Bool
    }
}

extension FormatStyle where Self == CLLocationCoordinate2D.GeoURIFormatStyle {
    public static var geoURI:  CLLocationCoordinate2D.GeoURIFormatStyle { .init() }
}
