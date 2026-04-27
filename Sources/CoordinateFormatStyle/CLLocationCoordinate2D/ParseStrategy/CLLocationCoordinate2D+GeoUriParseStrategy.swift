import Foundation
import CoreLocation
import GeoURI

extension CLLocationCoordinate2D {
    
    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from ['geo' URI](https://geouri.org) formatted strings.
    ///
    /// - ``CoordinateFormat/geoURI``
    public struct GeoUriParseStrategy: Foundation.ParseStrategy, Sendable {
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D
        
        public func parse(_ value: String) throws -> CLLocationCoordinate2D {
            return try GeoURI(string: value).coordinate
        }
    }
}

extension ParseStrategy where Self == CLLocationCoordinate2D.GeoUriParseStrategy {
    public static var geoURI:  CLLocationCoordinate2D.GeoUriParseStrategy { .init() }
}

extension CLLocationCoordinate2D.GeoUriFormatStyle: ParseableFormatStyle {
    public var parseStrategy: CLLocationCoordinate2D.GeoUriParseStrategy {
        .init()
    }
}
