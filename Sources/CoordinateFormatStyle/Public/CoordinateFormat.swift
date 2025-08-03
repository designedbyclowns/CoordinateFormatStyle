import Foundation

/// The format uses to represent a `CLLocationCoordinate2d` value as a string.
public enum CoordinateFormat: String, Codable {
    
    /// Decimal Degrees (DD) coordinate format.
    ///
    /// Commonly used on the web and computer systems.
    ///
    /// __Examples__
    /// ```
    /// 48.11638, -122.77527
    /// 48.11638°, -122.77527°
    /// 48.11638° N, 122.77527° W
    /// ```
    case decimalDegrees
    
    /// Degrees and Decimal Minutes (DDM) coordinate format.
    ///
    /// Commonly used by electronic navigation equipment.
    ///
    /// __Examples__
    /// ```
    /// 48 06.983, -122 46.516
    /// 48° 06.983', -122° 46.516'
    /// 48° 06.983′, -122° 46.516′
    /// 48°06.983', -122°46.516'
    /// 48° 06.983' N, 122° 46.516' W
    /// 48°06.983'N, 122°46.516'W
    /// ```
    case degreesDecimalMinutes
    
     /// Degrees, Minutes, Seconds (DMS) coordinate format.
     ///
     /// This is the format commonly used on printed charts and maps.
    case degreesMinutesSeconds
    
    /// GeoURI coordinate format.
    ///
    /// A Uniform Resource Identifier for Geographic Locations ('geo' URI).
    case geoURI
    
    /// Universal Transverse Mercator (UTM) coordinate format.
    case utm
}

extension CoordinateFormat: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
