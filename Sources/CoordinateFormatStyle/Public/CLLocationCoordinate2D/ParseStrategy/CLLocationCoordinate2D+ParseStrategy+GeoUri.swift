public import Foundation
public import CoreLocation
import GeoURI

extension CLLocationCoordinate2D.ParseStrategy {

    /// A parse strategy for creating `CLLocationCoordinate2D` values
    /// from ['geo' URI](https://geouri.org) formatted strings.
    public struct GeoUri: Foundation.ParseStrategy, Sendable {
        public typealias ParseInput = String
        public typealias ParseOutput = CLLocationCoordinate2D

        /// Parses a 'geo' URI string into a coordinate.
        /// - Parameter value: A string such as `"geo:48.11638,-122.77527;crs=wgs84"`.
        /// - Returns: The parsed coordinate.
        /// - Throws: A ``ParsingError`` or a `GeoURI` error if `value` is malformed
        ///   or uses an unsupported coordinate reference system.
        public func parse(_ value: String) throws -> CLLocationCoordinate2D {
            return try GeoURI(string: value).coordinate
        }
    }
}
