public import Foundation
public import CoreLocation

extension CLLocationCoordinate2D.FormatStyle {

    /// A structure that converts between `CLLocationCoordinate2D` values and
    /// their textual representations using the Degrees, Minutes, Seconds (DMS) format.
    public struct DegreesMinutesSeconds : Foundation.FormatStyle, Sendable {
        public typealias FormatInput = CLLocationCoordinate2D
        public typealias FormatOutput = String

        /// The characters used to annotate degrees, minutes, and seconds.
        public var symbolStyle: SymbolStyle = .canonical

        /// How the latitude and longitude ordinal direction is rendered.
        public var ordinalStyle: OrdinalDirectionStyle

        /// When `true`, omits whitespace between components for a more compact form.
        public var compact: Bool

        /// Creates a Degrees, Minutes, Seconds format style.
        /// - Parameters:
        ///   - symbolStyle: The symbol style. Defaults to ``SymbolStyle/canonical``.
        ///   - ordinalStyle: The ordinal direction style. Defaults to ``OrdinalDirectionStyle/suffix``.
        ///   - compact: When `true`, omits whitespace between components. Defaults to `false`.
        public init(
            symbolStyle: SymbolStyle = .canonical,
            ordinalStyle: OrdinalDirectionStyle = .suffix,
            compact: Bool = false
        ) {
            self.symbolStyle = symbolStyle
            self.ordinalStyle = ordinalStyle
            self.compact = compact
        }

        /// Returns a copy of this format style with the given symbol style.
        public func symbolStyle(_ symbolStyle: SymbolStyle) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }

        /// Returns a copy of this format style with the given ordinal direction style.
        public func ordinalStyle(_ ordinalStyle: OrdinalDirectionStyle) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }

        /// Returns a copy of this format style with the given compact setting.
        public func compact(_ compact: Bool) -> Self {
            .init(symbolStyle: symbolStyle, ordinalStyle: ordinalStyle, compact: compact)
        }

        /// Formats `value` as a Degrees, Minutes, Seconds string.
        /// - Parameter value: The coordinate to format.
        /// - Returns: A string such as `"48° 6′ 59″ N, 122° 46′ 31″ W"`, or an empty string
        ///   if `value` is not a valid coordinate.
        public func format(_ value: CLLocationCoordinate2D) -> String {
            guard CLLocationCoordinate2DIsValid(value) else { return "" }

            let style = CLLocationDegrees.FormatStyle.DegreesMinutesSeconds()
                .symbolStyle(symbolStyle)
                .ordinalStyle(ordinalStyle)
                .compact(compact)

            let Φ = style.orientation(.latitude).format(value.latitude)
            let λ = style.orientation(.longitude).format(value.longitude)

            guard Φ.isEmpty == false, λ.isEmpty == false else { return "" }

            return "\(Φ), \(λ)"
        }
    }

    /// Sexagesimal, also known as base 60 is a numeral system with sixty as its base.
    ///
    /// It originated with the ancient Sumerians in the 3rd millennium BC, was passed down to
    /// the ancient Babylonians, and is still used—in a modified form—for measuring time,
    /// angles, and geographic coordinates.
    public typealias Sexagesimal = DegreesMinutesSeconds

}

extension CLLocationCoordinate2D.FormatStyle.DegreesMinutesSeconds: ParseableFormatStyle {
    /// The matching parse strategy for round-tripping with this format style.
    public var parseStrategy: CLLocationCoordinate2D.ParseStrategy.DegreesMinutesSeconds {
        .init()
    }
}
