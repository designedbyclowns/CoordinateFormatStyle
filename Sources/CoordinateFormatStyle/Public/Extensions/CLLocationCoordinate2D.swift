public import Foundation
public import CoreLocation

extension CLLocationCoordinate2D {
    /// Creates and initializes a coordinate by parsing a string according to the provided format style.
    /// - Parameters:
    ///   - value: A string that contains a formatted coordinate.
    ///   - parseStrategy: A format style that describes formatting conventions used by the string. The initializer uses this format’s ``CLLocationCoordinate2D.ParseStrategy`` to parse the string.
    ///
    /// This initializer throws an error if the format style fails to parse the string into a coordinate value.
    public init<P: Foundation.ParseStrategy>(
        _ value: String,
        parseStrategy: P
    ) throws where P.ParseInput == String, P.ParseOutput == CLLocationCoordinate2D {
        self = try parseStrategy.parse(value)
    }
    
    /// Formats the coordinate using the provided format style.
    /// - Parameter style: The format style to apply when formatting the coordinate.
    /// - Returns: A localized, formatted string representation of the coordinate.
    ///
    /// Use this method when you want to format a `CLLocationCoordinate2D` value with a specific format style or multiple format styles. The following example shows the results of formatting a given decimal value with format styles for the en_US and fr_FR locales:
    /// ```swift
    /// let coordinate = CLLocationCoordinate2D(latitude: -48.876667, longitude: -123.393333)
    /// let formatted = coordinate.formatted(.decimalDegrees.ordinalStyle(.suffix)) // "48.87667° S, 123.39333° W"
    /// ```
    public func formatted<F: Foundation.FormatStyle>(_ style: F) -> F.FormatOutput where F.FormatInput == Self {
        style.format(self)
    }
    
    /// Formats the coordinate using the default format style.
    ///
    /// Equivalent to `formatted(.degreesMinutesSeconds.ordinalStyle(.suffix).symbolStyle(.canonical))`.
    ///
    /// - Returns: A string such as `"48° 6′ 59″ N, 122° 46′ 31″ W"`.
    public func formatted() -> String  {
        self.formatted(.degreesMinutesSeconds
            .ordinalStyle(.suffix)
            .symbolStyle(.canonical)
        )
    }
}

