public import Foundation
public import UTMConversion

public extension UTMCoordinate {

    /// A structure that converts between `UTMCoordinate` values and
    /// their textual representations.
    struct FormatStyle: Foundation.FormatStyle, Sendable {

        /// Creates a UTM format style.
        /// - Parameter compact: When `true`, omits whitespace between the magnitude and
        ///   the hemisphere letter (e.g. `"516726mE"` instead of `"516726m E"`).
        ///   Defaults to `false`.
        public init(
            compact: Bool = false
        ) {
            self.compact = compact
        }

        /// When `true`, omits whitespace between the magnitude and hemisphere letter.
        public var compact: Bool

        // MARK: - FormatStyle

        public typealias FormatInput = UTMCoordinate
        public typealias FormatOutput = String

        /// Formats `value` as a UTM string.
        /// - Parameter value: The UTM coordinate to format.
        /// - Returns: A string such as `"10U 516726m E 5329260m N"`.
        public func format(_ value: UTMCoordinate) -> String {
            let band = value.coordinate().latitudeBand?.rawValue ?? ""
            let easting = value.easting.formatted(Self.numberStyle).padding(toLength: 6, withPad: "0", startingAt: 0)
            let northing = value.northing.formatted(Self.numberStyle).padding(toLength: 7, withPad: "0", startingAt: 0)

            return "\(value.zone)\(band) \(easting)m\(eastingSuffix) \(northing)m\(northingSuffix)"
        }

        /// Returns a copy of this format style with the given compact setting.
        public func compact(_ compact: Bool) -> Self {
            .init(compact: compact)
        }

        // MARK: - Private

        private static let numberStyle = FloatingPointFormatStyle<Double>()
            .rounded()
            .precision(.integerLength(6...7))
            .precision(.fractionLength(0))
            .sign(strategy: .never)
            .grouping(.never)

        private var eastingSuffix: String {
            return compact ?  "E" : " E"
        }

        private var northingSuffix: String {
            return compact ?  "N" : " N"
        }
    }
}

public extension UTMCoordinate {
    /// Formats `self` using the default UTM format style.
    /// - Returns: A string such as `"10U 516726m E 5329260m N"`.
    func formatted() -> String {
        Self.FormatStyle().format(self)
    }

    /// Formats `self` using the provided format style.
    /// - Parameter style: The format style to apply.
    /// - Returns: A representation of `self` produced by `style`.
    func formatted<F: Foundation.FormatStyle>(_ style: F) -> F.FormatOutput where F.FormatInput == UTMCoordinate {
        style.format(self)
    }
}
