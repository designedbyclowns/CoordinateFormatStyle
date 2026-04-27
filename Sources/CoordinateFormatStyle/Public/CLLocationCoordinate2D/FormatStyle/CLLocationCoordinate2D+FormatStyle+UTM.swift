public import Foundation
public import CoreLocation
import UTMConversion

extension CLLocationCoordinate2D.FormatStyle {

    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the [Universal Transverse Mercator (UTM)](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) coordinate system.
    public struct UTM: Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String

        /// When `true`, omits whitespace between the easting/northing magnitude and its
        /// hemisphere letter (e.g. `"516726mE"` instead of `"516726m E"`).
        public var compact: Bool

        /// Creates a UTM format style.
        /// - Parameter compact: When `true`, omits whitespace between components. Defaults to `false`.
        public init(compact: Bool = false) {
            self.compact = compact
        }

        /// Formats `value` as a UTM string.
        /// - Parameter value: The coordinate to format.
        /// - Returns: A string such as `"10U 516726m E 5329260m N"`, or an empty string
        ///   if `value` is not a valid coordinate.
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value), let utm = try? value.utmCoordinate() else {
                return ""
            }

            let style = UTMCoordinate.FormatStyle().compact(compact)

            return style.format(utm)
        }

        /// Returns a copy of this format style with the given compact setting.
        public func compact(_ compact: Bool) -> Self {
            .init(compact: compact)
        }
    }
}

extension CLLocationCoordinate2D.FormatStyle.UTM {
    /// The matching parse strategy for round-tripping with this format style.
    public var parseStrategy: CLLocationCoordinate2D.ParseStrategy.UTM {
        .init()
    }
}
