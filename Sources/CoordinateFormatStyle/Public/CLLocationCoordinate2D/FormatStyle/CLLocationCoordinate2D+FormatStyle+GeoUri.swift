public import Foundation
public import CoreLocation
import GeoURI

extension CLLocationCoordinate2D.FormatStyle {

    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the ['geo' URI](https://geouri.org) scheme format.
    public struct GeoUri : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String

        /// When `true`, the formatted string includes the `;crs=wgs84` parameter.
        public var includeCRS: Bool

        /// Creates a 'geo' URI format style.
        /// - Parameter includeCRS: When `true`, includes the `;crs=wgs84` parameter. Defaults to `true`.
        public init(includeCRS: Bool = true) {
            self.includeCRS = includeCRS
        }

        // MARK: Customization Method Chaining

        /// Returns a copy of this format style with the given `includeCRS` setting.
        public func includeCRS(_ includeCRS: Bool) -> Self {
            .init(includeCRS: includeCRS)
        }

        /// Formats `value` as a 'geo' URI.
        /// - Parameter value: The coordinate to format.
        /// - Returns: A string such as `"geo:48.11638,-122.77527;crs=wgs84"`, or an empty
        ///   string if `value` is not a valid coordinate.
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value), let geoURI = try? GeoURI(coordinate: value) else {
                return ""
            }
            return geoURI.formatted(includeCRS: includeCRS)
        }
    }
}

extension CLLocationCoordinate2D.FormatStyle.GeoUri: ParseableFormatStyle {
    /// The matching parse strategy for round-tripping with this format style.
    public var parseStrategy: CLLocationCoordinate2D.ParseStrategy.GeoUri {
        .init()
    }
}
