/// The format used to represent a `CLLocationCoordinate2d` value as a string.
public enum CoordinateFormat: String, Codable, Sendable {
    
    /// Decimal Degrees (DD).
    ///
    /// A notation for expressing latitude and longitude geographic coordinates as
    /// decimal fractions of a degree.
    ///
    /// Commonly used on the web and computer systems.
    ///
    ///Examples:
    /// ```
    /// 48.87667° S, 123.39333° W
    /// -48.87667°, 123.39333°
    /// ```
    case decimalDegrees
    
    /// Degrees and Decimal Minutes (DDM).
    ///
    /// Decimal degrees (DD) is a notation for expressing latitude and longitude geographic coordinates as decimal fractions of a degree.
    ///
    /// Commonly used by electronic navigation equipment.
    case degreesDecimalMinutes
    
    /// Degrees, Minutes, Seconds (DMS).
    ///
    /// Also known as [Sexagesimal](https://en.wikipedia.org/wiki/Sexagesimal).
    /// This is the format commonly used on printed charts and maps.
    case degreesMinutesSeconds
    
    /// GeoURI.
    ///
    /// A Uniform Resource Identifier for Geographic Locations ('geo' URI).
    case geoURI
    
    /// Universal Transverse Mercator (UTM).
    case utm
}

extension CoordinateFormat: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
